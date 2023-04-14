import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';

void main() {
  testWidgets('SliverGap constructors', (WidgetTester tester) async {
    const SliverGap a = SliverGap(0);
    expect(a.mainAxisExtent, 0);
    expect(a.color, null);

    const SliverGap b = SliverGap(10, color: Colors.red);
    expect(b.mainAxisExtent, 10);
    expect(b.color, Colors.red);
  });

  testWidgets('Horizontal SliverGap layoutExtent', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          slivers: <Widget>[
            SliverGap(100),
          ],
        ),
      ),
    );

    final RenderSliver sliver = tester.renderObject(find.byType(SliverGap));
    expect(sliver.geometry!.layoutExtent, 100);
    expect(sliver.geometry!.paintExtent, 100);
  });

  testWidgets('Vertical SliverGap layoutExtent', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverGap(100),
          ],
        ),
      ),
    );

    final RenderSliver sliver = tester.renderObject(find.byType(SliverGap));
    expect(sliver.geometry!.layoutExtent, 100);
    expect(sliver.geometry!.paintExtent, 100);
  });
}
