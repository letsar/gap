import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/src/rendering/gap.dart';

/// A widget that takes a fixed amount of space in the direction of its
/// ancestors.
///
/// It only works in the following cases:
/// - It is a descendant of a [Row], [Column], or [Flex],
/// and the path from the [Gap] widget to its enclosing [Row], [Column], or
/// [Flex] must contain only [StatelessWidget]s or [StatefulWidget]s (not other
/// kinds of widgets, like [RenderObjectWidget]s).
/// - It is a descendant of a [Scrollable].
///
/// See also:
///
///  * [MaxGap], a gap that can take, at most, the amount of space specified.
///  * [SliverGap], the sliver version of this widget.
class Gap extends StatelessWidget {
  /// Creates a widget that takes a fixed [mainAxisExtent] of space in the
  /// direction of its ancestors.
  ///
  /// The [mainAxisExtent] must not be null and must be positive.
  /// The [crossAxisExtent] must be either null or positive.
  const Gap(
    this.mainAxisExtent, {
    Key? key,
    this.fallbackDirection,
    this.crossAxisExtent,
    this.color,
    this.thickness,
    this.indent,
    this.endIndent,
  })  : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
        assert(crossAxisExtent == null || crossAxisExtent >= 0),
        assert(thickness == null || thickness >= 0.0),
        assert(indent == null || indent >= 0.0),
        assert(endIndent == null || endIndent >= 0.0),
        super(key: key);

  /// Creates a widget that takes a fixed [mainAxisExtent] of space in the
  /// direction of its ancestors and expands in the cross axis direction.
  ///
  /// The [mainAxisExtent] must not be null and must be positive.
  const Gap.expand(
    double mainAxisExtent, {
    Key? key,
    Axis? fallbackDirection,
    Color? color,
    double? thickness,
    double? indent,
    double? endIndent,
  }) : this(
          mainAxisExtent,
          key: key,
          fallbackDirection: fallbackDirection,
          crossAxisExtent: double.infinity,
          color: color,
          thickness: thickness,
          indent: indent,
          endIndent: endIndent,
        );

  /// The amount of space this widget takes in the direction of its ancestors.
  ///
  /// For example:
  /// - If the ancestors is a [Column] this is the height of this widget.
  /// - If the ancestors is a [Row] this is the width of this widget.
  ///
  /// Must not be null and must be positive.
  final double mainAxisExtent;

  /// The amount of space this widget takes in the opposite direction of the
  /// ancestors.
  ///
  /// For example:
  /// - If the ancestors is a [Column] this is the width of this widget.
  /// - If the ancestors is a [Row] this is the height of this widget.
  ///
  /// Must be positive or null. If it's null (the default) the cross axis extent
  /// will be the same as the constraints of the ancestors in the opposite
  /// direction.
  final double? crossAxisExtent;

  /// The color used to fill the gap.
  final Color? color;

  /// The direction to use when its ancestors is not a [Flex] widget.
  final Axis? fallbackDirection;

  /// The thickness of the line drawn within the gap.
  ///
  /// A gap with a [thickness] of 0.0 is always drawn as a line with a
  /// width of exactly one device pixel.
  ///
  /// If this is null, defaults to 0.0.
  final double? thickness;

  /// The amount of empty space to the leading edge of the gap.
  ///
  /// If this is null, defaults to 0.0.
  final double? indent;

  /// The amount of empty space to the trailing edge of the gap.
  ///
  /// If this is null, defaults to 0.0.
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    return _RawGap(
      mainAxisExtent,
      crossAxisExtent: crossAxisExtent,
      color: color,
      fallbackDirection: fallbackDirection,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}

class _RawGap extends LeafRenderObjectWidget {
  const _RawGap(
    this.mainAxisExtent, {
    Key? key,
    this.crossAxisExtent,
    this.color,
    this.fallbackDirection,
    this.thickness,
    this.indent,
    this.endIndent,
  })  : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
        assert(crossAxisExtent == null || crossAxisExtent >= 0),
        assert(thickness == null || thickness >= 0),
        assert(indent == null || indent >= 0),
        assert(endIndent == null || endIndent >= 0),
        super(key: key);

  final double mainAxisExtent;

  final double? crossAxisExtent;

  final Color? color;

  final Axis? fallbackDirection;

  final double? thickness;

  final double? indent;

  final double? endIndent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderGap(
      mainAxisExtent: mainAxisExtent,
      crossAxisExtent: crossAxisExtent ?? 0,
      color: color,
      fallbackDirection: fallbackDirection,
      thickness: thickness ?? 0,
      indent: indent ?? 0,
      endIndent: endIndent ?? 0,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderGap renderObject) {
    renderObject
      ..mainAxisExtent = mainAxisExtent
      ..crossAxisExtent = crossAxisExtent ?? 0
      ..color = color
      ..fallbackDirection = fallbackDirection
      ..thickness = thickness ?? 0
      ..indent = indent ?? 0
      ..endIndent = endIndent ?? 0;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('mainAxisExtent', mainAxisExtent));
    properties.add(
        DoubleProperty('crossAxisExtent', crossAxisExtent, defaultValue: 0));
    properties.add(ColorProperty('color', color));
    properties.add(EnumProperty<Axis>('fallbackDirection', fallbackDirection));
    properties.add(DoubleProperty('thickness', thickness));
    properties.add(DoubleProperty('indent', indent));
    properties.add(DoubleProperty('endIndent', endIndent));
  }
}
