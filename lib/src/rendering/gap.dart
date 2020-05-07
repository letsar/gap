import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class RenderGap extends RenderBox {
  RenderGap({
    double mainAxisExtent,
    double crossAxisExtent,
    Color color,
  })  : _mainAxisExtent = mainAxisExtent,
        _crossAxisExtent = crossAxisExtent,
        _color = color;

  double get mainAxisExtent => _mainAxisExtent;
  double _mainAxisExtent;
  set mainAxisExtent(double value) {
    if (_mainAxisExtent != value) {
      _mainAxisExtent = value;
      markNeedsLayout();
    }
  }

  double get crossAxisExtent => _crossAxisExtent;
  double _crossAxisExtent;
  set crossAxisExtent(double value) {
    if (_crossAxisExtent != value) {
      _crossAxisExtent = value;
      markNeedsLayout();
    }
  }

  Color get color => _color;
  Color _color;
  set color(Color value) {
    if (_color != value) {
      _color = value;
      markNeedsPaint();
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _computeIntrinsicExtent(
      Axis.horizontal,
      () => super.computeMinIntrinsicWidth(height),
    );
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _computeIntrinsicExtent(
      Axis.horizontal,
      () => super.computeMaxIntrinsicWidth(height),
    );
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _computeIntrinsicExtent(
      Axis.vertical,
      () => super.computeMinIntrinsicHeight(width),
    );
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _computeIntrinsicExtent(
      Axis.vertical,
      () => super.computeMaxIntrinsicHeight(width),
    );
  }

  double _computeIntrinsicExtent(Axis axis, double Function() compute) {
    final AbstractNode parentNode = parent;
    if (parentNode is RenderFlex && parentNode.direction == axis) {
      return _mainAxisExtent;
    } else {
      if (_crossAxisExtent.isFinite) {
        return _crossAxisExtent;
      } else {
        return compute();
      }
    }
  }

  @override
  void performLayout() {
    final AbstractNode flex = parent;
    if (flex is RenderFlex) {
      if (flex.direction == Axis.horizontal) {
        size = constraints.constrain(Size(mainAxisExtent, crossAxisExtent));
      } else {
        size = constraints.constrain(Size(crossAxisExtent, mainAxisExtent));
      }
    } else {
      throw FlutterError(
        'A Gap widget must be placed directly inside a Flex widget',
      );
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (color != null) {
      final Paint paint = Paint()..color = color;
      context.canvas.drawRect(offset & size, paint);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('mainAxisExtent', mainAxisExtent));
    properties.add(DoubleProperty('crossAxisExtent', crossAxisExtent));
    properties.add(ColorProperty('color', color));
  }
}
