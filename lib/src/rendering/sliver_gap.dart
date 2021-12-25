import 'package:flutter/rendering.dart';

class RenderSliverGap extends RenderSliver {
  RenderSliverGap({
    required double mainAxisExtent,
    Color? color,
    required double thickness,
    required double indent,
    required double endIndent,
  })  : _mainAxisExtent = mainAxisExtent,
        _color = color,
        _thickness = thickness,
        _indent = indent,
        _endIndent = endIndent;

  double get mainAxisExtent => _mainAxisExtent;
  double _mainAxisExtent;
  set mainAxisExtent(double value) {
    if (_mainAxisExtent != value) {
      _mainAxisExtent = value;
      markNeedsLayout();
    }
  }

  Color? get color => _color;
  Color? _color;
  set color(Color? value) {
    if (_color != value) {
      _color = value;
      markNeedsPaint();
    }
  }

  double get thickness => _thickness;
  double _thickness;
  set thickness(double value) {
    if (_thickness != value) {
      _thickness = value;
      markNeedsPaint();
    }
  }

  double get indent => _indent;
  double _indent;
  set indent(double value) {
    if (_indent != value) {
      _indent = value;
      markNeedsPaint();
    }
  }

  double get endIndent => _endIndent;
  double _endIndent;
  set endIndent(double value) {
    if (_endIndent != value) {
      _endIndent = value;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    final double paintExtent = calculatePaintOffset(
      constraints,
      from: 0,
      to: mainAxisExtent,
    );
    final double cacheExtent = calculateCacheOffset(
      constraints,
      from: 0,
      to: mainAxisExtent,
    );

    assert(paintExtent.isFinite);
    assert(paintExtent >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: mainAxisExtent,
      paintExtent: paintExtent,
      cacheExtent: cacheExtent,
      maxPaintExtent: mainAxisExtent,
      hitTestExtent: paintExtent,
      hasVisualOverflow: mainAxisExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
      visible: color != null,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (color != null) {
      final Paint paint = Paint()
        ..strokeWidth = 0.0
        ..color = color!;
      final Size size = constraints
          .asBoxConstraints(
            minExtent: geometry!.paintExtent,
            maxExtent: geometry!.paintExtent,
          )
          .constrain(Size.zero);
      final Rect temp = offset & size;
      final Path path = Path();
      if (constraints.axis == Axis.horizontal) {
        final rect = Rect.fromLTRB(
            temp.center.dx - thickness / 2.0,
            temp.top + indent,
            temp.center.dx + thickness / 2.0,
            temp.bottom - endIndent);
        if (thickness == 0.0) {
          paint.style = PaintingStyle.stroke;
          path.moveTo(rect.topCenter.dx, rect.topCenter.dy);
          path.lineTo(rect.bottomCenter.dx, rect.bottomCenter.dy);
        } else {
          paint.style = PaintingStyle.fill;
          path.addRect(rect);
        }
      } else {
        final rect = Rect.fromLTRB(
            temp.left + indent,
            temp.center.dy - thickness / 2.0,
            temp.right - endIndent,
            temp.center.dy + thickness / 2.0);
        if (thickness == 0.0) {
          paint.style = PaintingStyle.stroke;
          path.moveTo(rect.centerLeft.dx, rect.centerLeft.dy);
          path.lineTo(rect.centerRight.dx, rect.centerRight.dy);
        } else {
          paint.style = PaintingStyle.fill;
          path.addRect(rect);
        }
      }
      context.canvas.drawPath(path, paint);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('mainAxisExtent', mainAxisExtent));
    properties.add(ColorProperty('color', color));
    properties.add(DoubleProperty('thickness', thickness));
    properties.add(DoubleProperty('indent', indent));
    properties.add(DoubleProperty('endIndent', endIndent));
  }
}
