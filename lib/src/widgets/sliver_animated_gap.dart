import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/src/widgets/sliver_gap.dart';

/// Animated version of [SliverGap] that gradually changes its values over a period of time.
///
/// The [SliverAnimatedGap] will automatically animate between the old and
/// new values of properties when they change using the provided curve and
/// duration. Properties that are null are not animated.
///
/// See also:
///
///  * [AnimatedGap], the [RenderBox] version of this widget.
class SliverAnimatedGap extends ImplicitlyAnimatedWidget {
  /// Creates a [SliverGap] that animates its parameters implicitly.
  ///
  /// The [curve] and [duration] arguments must not be null.
  const SliverAnimatedGap(
    this.mainAxisExtent, {
    Key? key,
    this.color,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  })  : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
        super(
          key: key,
          curve: curve,
          duration: duration,
          onEnd: onEnd,
        );

  /// {@macro sliverGap.mainAxisExtent}
  final double mainAxisExtent;

  /// {@macro sliverGap.color}
  final Color? color;

  @override
  AnimatedWidgetBaseState<SliverAnimatedGap> createState() =>
      _SliverAnimatedGapState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('mainAxisExtent', mainAxisExtent));
    properties.add(ColorProperty('color', color, defaultValue: null));
  }
}

class _SliverAnimatedGapState
    extends AnimatedWidgetBaseState<SliverAnimatedGap> {
  Tween<double>? _mainAxisExtent;
  ColorTween? _color;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _mainAxisExtent = visitor(
      _mainAxisExtent,
      widget.mainAxisExtent,
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;

    _color = visitor(
      _color,
      widget.color,
      (dynamic value) => ColorTween(begin: value as Color),
    ) as ColorTween?;
  }

  @override
  Widget build(BuildContext context) {
    final mainAxisExtent =
        _mainAxisExtent?.evaluate(animation).clamp(0.0, double.infinity);

    final color = _color?.evaluate(animation);

    return SliverGap(
      mainAxisExtent ?? 0,
      color: color,
    );
  }
}
