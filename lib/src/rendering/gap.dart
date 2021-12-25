import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class RenderGap extends RenderBox {
  RenderGap({
    required double mainAxisExtent,
    required double crossAxisExtent,
    Axis? fallbackDirection,
    Color? color,
    required double thickness,
    required double indent,
    required double endIndent,
  })  : _mainAxisExtent = mainAxisExtent,
        _crossAxisExtent = crossAxisExtent,
        _color = color,
        _fallbackDirection = fallbackDirection,
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

  double? get crossAxisExtent => _crossAxisExtent;
  double? _crossAxisExtent;
  set crossAxisExtent(double? value) {
    if (_crossAxisExtent != value) {
      _crossAxisExtent = value;
      markNeedsLayout();
    }
  }

  Axis? get fallbackDirection => _fallbackDirection;
  Axis? _fallbackDirection;
  set fallbackDirection(Axis? value) {
    if (_fallbackDirection != value) {
      _fallbackDirection = value;
      markNeedsLayout();
    }
  }

  Axis? get _direction {
    AbstractNode? parentNode = parent;
    while (parentNode != null) {
      if (parentNode is RenderFlex) {
        return parentNode.direction;
      } else {
        parentNode = parentNode.parent;
      }
    }
    return fallbackDirection;
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
  double computeMinIntrinsicWidth(double height) {
    return _computeIntrinsicExtent(
      Axis.horizontal,
      () => super.computeMinIntrinsicWidth(height),
    )!;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _computeIntrinsicExtent(
      Axis.horizontal,
      () => super.computeMaxIntrinsicWidth(height),
    )!;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _computeIntrinsicExtent(
      Axis.vertical,
      () => super.computeMinIntrinsicHeight(width),
    )!;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _computeIntrinsicExtent(
      Axis.vertical,
      () => super.computeMaxIntrinsicHeight(width),
    )!;
  }

  double? _computeIntrinsicExtent(Axis axis, double Function() compute) {
    final Axis? direction = _direction;
    if (direction == axis) {
      return _mainAxisExtent;
    } else {
      if (_crossAxisExtent!.isFinite) {
        return _crossAxisExtent;
      } else {
        return compute();
      }
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final Axis? direction = _direction;

    if (direction != null) {
      if (direction == Axis.horizontal) {
        return constraints.constrain(Size(mainAxisExtent, crossAxisExtent!));
      } else {
        return constraints.constrain(Size(crossAxisExtent!, mainAxisExtent));
      }
    } else {
      throw FlutterError(
        'A Gap widget must be placed inside a Flex widget '
        'or its fallbackDirection must not be null',
      );
    }
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (color != null) {
      final Paint paint = Paint()
        ..strokeWidth = 0.0
        ..color = color!;
      final Axis direction = _direction!;
      final Rect temp = offset & size;
      final Path path = Path();
      if (direction == Axis.horizontal) {
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
    properties.add(DoubleProperty('crossAxisExtent', crossAxisExtent));
    properties.add(ColorProperty('color', color));
    properties.add(EnumProperty<Axis>('fallbackDirection', fallbackDirection));
    properties.add(DoubleProperty('thickness', thickness));
    properties.add(DoubleProperty('indent', indent));
    properties.add(DoubleProperty('endIndent', endIndent));
  }
}
