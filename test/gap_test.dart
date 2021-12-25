import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';

void main() {
  testWidgets('Gap constructors', (WidgetTester tester) async {
    const Gap a = Gap(0);
    expect(a.mainAxisExtent, 0);
    expect(a.crossAxisExtent, null);
    expect(a.color, null);

    const Gap b = Gap(10, crossAxisExtent: 20, color: Colors.red);
    expect(b.mainAxisExtent, 10);
    expect(b.crossAxisExtent, 20);
    expect(b.color, Colors.red);

    const Gap e = Gap.expand(10, color: Colors.red);
    expect(e.mainAxisExtent, 10);
    expect(e.crossAxisExtent, double.infinity);
    expect(e.color, Colors.red);
  });

  testWidgets('Gap size in a Row', (WidgetTester tester) async {
    await tester.pumpWidget(
      Row(
        textDirection: TextDirection.ltr,
        children: const <Widget>[
          Gap(100, crossAxisExtent: 20),
        ],
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.width, 100);
    expect(box.size.height, 20);
  });

  testWidgets('Gap size in a Column', (WidgetTester tester) async {
    await tester.pumpWidget(
      Column(
        textDirection: TextDirection.ltr,
        children: const <Widget>[
          Gap(100, crossAxisExtent: 20),
        ],
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.height, 100);
    expect(box.size.width, 20);
  });

  testWidgets('Gap.expand size in a Column', (WidgetTester tester) async {
    await tester.pumpWidget(
      Center(
        child: SizedBox(
          width: 200,
          child: Column(
            textDirection: TextDirection.ltr,
            children: const <Widget>[
              Gap.expand(100),
            ],
          ),
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.height, 100);
    expect(box.size.width, 200);
  });

  testWidgets(
      'Throws FlutterError with correct message when Gap is not inside a Flex',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const Gap(0),
    );

    await tester.pump();

    final dynamic error = tester.takeException();
    expect(error, isFlutterError);
    expect(
      error.toStringDeep(),
      equalsIgnoringHashCodes(
        'FlutterError\n'
        '   A Gap widget must be placed inside a Flex widget or its\n'
        '   fallbackDirection must not be null\n',
      ),
    );
  });
}
