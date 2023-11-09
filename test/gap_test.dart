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

    const MaxGap c = MaxGap(0);
    expect(c.mainAxisExtent, 0);
    expect(c.crossAxisExtent, null);
    expect(c.color, null);

    const MaxGap d = MaxGap(10, crossAxisExtent: 20, color: Colors.red);
    expect(d.mainAxisExtent, 10);
    expect(d.crossAxisExtent, 20);
    expect(d.color, Colors.red);

    const Gap e = Gap.expand(10, color: Colors.red);
    expect(e.mainAxisExtent, 10);
    expect(e.crossAxisExtent, double.infinity);
    expect(e.color, Colors.red);

    const MaxGap f = MaxGap.expand(10, color: Colors.red);
    expect(f.mainAxisExtent, 10);
    expect(f.crossAxisExtent, double.infinity);
    expect(f.color, Colors.red);
  });

  testWidgets('Gap size in a Row', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Row(
        textDirection: TextDirection.ltr,
        children: <Widget>[
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
      const Column(
        textDirection: TextDirection.ltr,
        children: <Widget>[
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
      const Center(
        child: SizedBox(
          width: 200,
          child: Column(
            textDirection: TextDirection.ltr,
            children: <Widget>[
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

  testWidgets('MaxGap size in a Row', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Row(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          MaxGap(100, crossAxisExtent: 20),
        ],
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(MaxGap));
    expect(box.size.width, 100);
    expect(box.size.height, 20);
  });

  testWidgets('MaxGap size in a constrained Row', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Center(
        child: SizedBox(
          width: 50,
          child: Row(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              MaxGap(100, crossAxisExtent: 20),
            ],
          ),
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(MaxGap));
    expect(box.size.width, 50);
    expect(box.size.height, 20);
  });

  testWidgets('MaxGap size in a Column', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Column(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          MaxGap(100, crossAxisExtent: 20),
        ],
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(MaxGap));
    expect(box.size.height, 100);
    expect(box.size.width, 20);
  });

  testWidgets('MaxGap size in a constrained Column',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const Center(
        child: SizedBox(
          height: 50,
          child: Column(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              MaxGap(100, crossAxisExtent: 20),
            ],
          ),
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(MaxGap));
    expect(box.size.height, 50);
    expect(box.size.width, 20);
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
        '   A Gap widget must be placed directly inside a Flex widget or its\n'
        '   fallbackDirection must not be null\n',
      ),
    );
  });

  testWidgets('gap extension size in a Row', (WidgetTester tester) async {
    await tester.pumpWidget(
      Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            const SizedBox.square(dimension: 10),
            const SizedBox.square(dimension: 10),
            const SizedBox.square(dimension: 10),
          ].gap(10),
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Row));
    expect(box.size.width, 50);
    expect(box.size.height, 10);
  });
}
