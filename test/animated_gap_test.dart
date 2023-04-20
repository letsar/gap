import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';

const _animationDuration = Duration(milliseconds: 100);
const _animationHalfDuration = Duration(milliseconds: 50);

void main() {
  testWidgets(
    'AnimatedGap.debugFillProperties',
    (WidgetTester tester) async {
      const AnimatedGap gap = AnimatedGap(
        200,
        crossAxisExtent: 10,
        color: Colors.red,
        curve: Curves.ease,
        duration: _animationDuration,
      );

      expect(gap, hasOneLineDescription);
    },
  );

  testWidgets(
    'AnimatedGap extents animation',
    (WidgetTester tester) async {
      const double mainAxisExtentA = 200;
      const double crossAxisExtentA = 10;

      const double mainAxisExtentB = 150;
      const double crossAxisExtentB = 35;

      await tester.pumpWidget(
        Column(
          children: const [
            AnimatedGap(
              mainAxisExtentA,
              crossAxisExtent: crossAxisExtentA,
              duration: _animationDuration,
            ),
          ],
        ),
      );

      RenderBox box = tester.renderObject(find.byType(Gap));
      expect(box.size.height, mainAxisExtentA);
      expect(box.size.width, crossAxisExtentA);

      await tester.pumpWidget(
        Column(
          children: const [
            AnimatedGap(
              mainAxisExtentB,
              crossAxisExtent: crossAxisExtentB,
              duration: _animationDuration,
            ),
          ],
        ),
      );

      box = tester.renderObject(find.byType(Gap));
      expect(box.size.height, mainAxisExtentA);
      expect(box.size.width, crossAxisExtentA);

      await tester.pump(_animationHalfDuration);

      box = tester.renderObject(find.byType(Gap));
      expect(box.size.height, (mainAxisExtentA + mainAxisExtentB) / 2);
      expect(box.size.width, (crossAxisExtentA + crossAxisExtentB) / 2);

      await tester.pump(_animationHalfDuration);

      box = tester.renderObject(find.byType(Gap));
      expect(box.size.height, mainAxisExtentB);
      expect(box.size.width, crossAxisExtentB);
    },
  );

  testWidgets(
    'AnimatedGap color animation',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        Column(
          children: const [
            AnimatedGap(
              10,
              color: Color(0xFFFFFFFF),
              duration: _animationDuration,
            ),
          ],
        ),
      );

      expect(
        tester.firstWidget<Gap>(find.byType(Gap)).color,
        const Color(0xFFFFFFFF),
      );

      await tester.pumpWidget(
        Column(
          children: const [
            AnimatedGap(
              10,
              color: Color(0xFF000000),
              duration: _animationDuration,
            ),
          ],
        ),
      );

      expect(
        tester.firstWidget<Gap>(find.byType(Gap)).color,
        const Color(0xFFFFFFFF),
      );

      await tester.pump(_animationHalfDuration);

      expect(
        tester.firstWidget<Gap>(find.byType(Gap)).color,
        const Color(0xFF7F7F7F),
      );

      await tester.pump(_animationHalfDuration);

      expect(
        tester.firstWidget<Gap>(find.byType(Gap)).color,
        const Color(0XFF000000),
      );
    },
  );

  testWidgets(
    'AnimatedGap onEnd callback',
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
                    Column(
                      children: [
                        AnimatedGap(
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
