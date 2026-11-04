import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';

void main() {
  testWidgets('Gap inside a WidgetSpan', (WidgetTester tester) async {
    await tester.pumpWidget(
      Center(
        child: RichText(
          textDirection: TextDirection.ltr,
          text: const TextSpan(
            text: 'a',
            children: <InlineSpan>[
              WidgetSpan(child: Gap(20)),
              TextSpan(text: 'b'),
            ],
          ),
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.width, 20);
    expect(box.size.height, 0);
  });

  testWidgets('Gap inside a horizontal Wrap', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Center(
        child: Wrap(
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Gap(20, crossAxisExtent: 10),
          ],
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.width, 20);
    expect(box.size.height, 10);
  });

  testWidgets('Gap inside a vertical Wrap', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Center(
        child: Wrap(
          direction: Axis.vertical,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Gap(20, crossAxisExtent: 10),
          ],
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.width, 10);
    expect(box.size.height, 20);
  });

  testWidgets('Gap inside a horizontal Wrap inside a vertical ListView',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: ListView(
          children: const <Widget>[
            Wrap(
              children: <Widget>[
                Gap(20, crossAxisExtent: 10),
              ],
            ),
          ],
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.width, 20);
    expect(box.size.height, 10);
  });
}
