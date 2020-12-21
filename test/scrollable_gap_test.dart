import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gap/gap.dart';

void main() {
  testWidgets('Gap inside horizontal ListView', (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const <Widget>[
                Gap(100),
              ],
            ),
          ),
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.width, 100);
    expect(box.size.height, 200);
  });

  testWidgets('Gap inside vertical ListView', (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 200,
            child: ListView(
              children: const <Widget>[
                Gap(100),
              ],
            ),
          ),
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.width, 200);
    expect(box.size.height, 100);
  });

  testWidgets('Gap with crossAxisExtent inside ListView',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 200,
            child: ListView(
              children: const <Widget>[
                Gap(100, crossAxisExtent: 20),
              ],
            ),
          ),
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.width, 200);
    expect(box.size.height, 100);
  });

  testWidgets('Gap inside a Row inside a SingleChildScrollView',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 200,
            child: SingleChildScrollView(
                child: Row(
                  children: const <Widget>[
                    Gap(100),
                  ],
                )),
          ),
        ),
      ),
    );
  });

  testWidgets('Gap inside a SingleChildScrollView inside a Row',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 500,
            child: Row(
              children: [
                Container(width: 100),
                const SingleChildScrollView(
                  child: Gap(100),
                ),
                Container(width: 100),
              ],
            ),
          ),
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.height, 100);
    expect(box.size.width, 0);
  });
}
