import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/src/rendering/sliver_gap.dart';

/// A sliver that takes a fixed amount of space.
///
/// See also:
///
///  * [Gap], the render box version of this widget.
class SliverGap extends LeafRenderObjectWidget {
  /// Creates a sliver that takes a fixed [mainAxisExtent] of space.
  ///
  /// The [mainAxisExtent] must not be null and must be positive.
  const SliverGap(
    this.mainAxisExtent, {
    Key? key,
    this.color,
    this.thickness,
    this.indent,
    this.endIndent,
  })  : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
        assert(thickness == null || thickness >= 0.0),
        assert(indent == null || indent >= 0.0),
        assert(endIndent == null || endIndent >= 0.0),
        super(key: key);

  /// The amount of space this widget takes in the direction of the parent.
  ///
  /// Must not be null and must be positive.
  final double mainAxisExtent;

  /// The color used to fill the gap.
  final Color? color;

  /// The thickness of the line drawn within the gap.
  ///
  /// A gap with a [thickness] of 0.0 is always drawn as a line with a
  /// width of exactly one device pixel.
  ///
  /// If this is null, defaults to 0.0.
  final double? thickness;

  /// the amount of empty space to the leading edge of the gap.
  ///
  /// If this is null, defaults to 0.0.
  final double? indent;

  /// The amount of empty space to the trailing edge of the gap.
  ///
  /// If this is null, defaults to 0.0.
  final double? endIndent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSliverGap(
      mainAxisExtent: mainAxisExtent,
      color: color,
      thickness: thickness ?? 0,
      indent: indent ?? 0,
      endIndent: endIndent ?? 0,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSliverGap renderObject) {
    renderObject
      ..mainAxisExtent = mainAxisExtent
      ..color = color
      ..thickness = thickness ?? 0
      ..indent = indent ?? 0
      ..endIndent = endIndent ?? 0;
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
