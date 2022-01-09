import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';

const _animationDuration = Duration(milliseconds: 100);
const _animationHalfDuration = Duration(milliseconds: 50);

void main() {
  testWidgets(
    'SliverAnimatedGap.debugFillProperties',
    (WidgetTester tester) async {
      const gap = SliverAnimatedGap(
        200,
        color: Colors.red,
        curve: Curves.ease,
        duration: _animationDuration,
      );

      expect(gap, hasOneLineDescription);
    },
  );

  testWidgets(
    'SliverAnimatedGap mainAxisExtent animation',
    (WidgetTester tester) async {
      const double mainAxisExtentA = 200;

      const double mainAxisExtentB = 150;

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: CustomScrollView(
            slivers: [
              SliverAnimatedGap(
                mainAxisExtentA,
                duration: _animationDuration,
              ),
            ],
          ),
        ),
      );

      RenderSliver sliver = tester.renderObject(find.byType(SliverGap));
      expect(sliver.geometry!.layoutExtent, mainAxisExtentA);

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: CustomScrollView(
            slivers: [
              SliverAnimatedGap(
                mainAxisExtentB,
                duration: _animationDuration,
              ),
            ],
          ),
        ),
      );

      sliver = tester.renderObject(find.byType(SliverGap));
      expect(sliver.geometry!.layoutExtent, mainAxisExtentA);

      await tester.pump(_animationHalfDuration);

      sliver = tester.renderObject(find.byType(SliverGap));
      expect(
        sliver.geometry!.layoutExtent,
        (mainAxisExtentA + mainAxisExtentB) / 2,
      );

      await tester.pump(_animationHalfDuration);

      sliver = tester.renderObject(find.byType(SliverGap));
      expect(sliver.geometry!.layoutExtent, mainAxisExtentB);
    },
  );

  testWidgets(
    'SliverAnimatedGap color animation',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: CustomScrollView(
            slivers: [
              SliverAnimatedGap(
                10,
                color: Color(0xFFFFFFFF),
                duration: _animationDuration,
              ),
            ],
          ),
        ),
      );

      expect(
        tester.firstWidget<SliverGap>(find.byType(SliverGap)).color,
        const Color(0xFFFFFFFF),
      );

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: CustomScrollView(
            slivers: [
              SliverAnimatedGap(
                10,
                color: Color(0xFF000000),
                duration: _animationDuration,
              ),
            ],
          ),
        ),
      );

      expect(
        tester.firstWidget<SliverGap>(find.byType(SliverGap)).color,
        const Color(0xFFFFFFFF),
      );

      await tester.pump(_animationHalfDuration);

      expect(
        tester.firstWidget<SliverGap>(find.byType(SliverGap)).color,
        const Color(0xFF7F7F7F),
      );

      await tester.pump(_animationHalfDuration);

      expect(
        tester.firstWidget<SliverGap>(find.byType(SliverGap)).color,
        const Color(0XFF000000),
      );
    },
  );

  testWidgets(
    'SliverAnimatedGap onEnd callback',
    (WidgetTester tester) async {
      const switchKey = Key('switchKey');
      const additionalDelay = Duration(milliseconds: 1);
      final mockOnEndFunction = _MockOnEndFunction();

      bool switchValue = false;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Material(
            child: StatefulBuilder(
              builder: (context, setState) {
                return Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverAnimatedGap(
                          switchValue ? 10 : 20,
                          onEnd: mockOnEndFunction.handler,
                          duration: _animationDuration,
                        ),
                      ],
                    ),
                    Switch(
                      value: switchValue,
                      key: switchKey,
                      onChanged: (value) => setState(() => switchValue = value),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      );

      final Finder widgetFinder = find.byKey(switchKey);
      await tester.tap(widgetFinder);

      await tester.pump();
      expect(mockOnEndFunction.called, 0);
      await tester.pump(_animationDuration);
      expect(mockOnEndFunction.called, 0);
      await tester.pump(additionalDelay);
      expect(mockOnEndFunction.called, 1);
    },
  );
}

class _MockOnEndFunction {
  int called = 0;

  void handler() {
    called++;
  }
}
