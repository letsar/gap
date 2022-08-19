import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/src/widgets/gap.dart';
import 'package:gap/src/widgets/sliver_animated_gap.dart';

/// Animated version of [Gap] that gradually changes its values over a period of time.
///
/// The [AnimatedGap] will automatically animate between the old and
/// new values of properties when they change using the provided curve and
/// duration. Properties that are null are not animated.
///
/// See also:
///
///  * [SliverAnimatedGap], the [RenderSliver] version of this widget.
class AnimatedGap extends ImplicitlyAnimatedWidget {
  /// Creates a [Gap] that animates its parameters implicitly.
  ///
  /// The [curve] and [duration] arguments must not be null.
  const AnimatedGap(
    this.mainAxisExtent, {
    Key? key,
    this.crossAxisExtent,
    this.color,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  })  : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
        assert(crossAxisExtent == null || crossAxisExtent >= 0),
        super(
          key: key,
          curve: curve,
          duration: duration,
          onEnd: onEnd,
        );

  /// {@macro gap.mainAxisExtent}
  final double mainAxisExtent;

  /// {@macro gap.crossAxisExtent}
  final double? crossAxisExtent;

  /// {@macro gap.color}
  final Color? color;

  @override
  AnimatedWidgetBaseState<AnimatedGap> createState() => _AnimatedGapState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('mainAxisExtent', mainAxisExtent));
    properties.add(
      DoubleProperty('crossAxisExtent', crossAxisExtent, defaultValue: null),
    );
    properties.add(ColorProperty('color', color, defaultValue: null));
  }
}

class _AnimatedGapState extends AnimatedWidgetBaseState<AnimatedGap> {
  Tween<double>? _mainAxisExtent;
  Tween<double>? _crossAxisExtent;
  ColorTween? _color;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _mainAxisExtent = visitor(
      _mainAxisExtent,
      widget.mainAxisExtent,
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;

    _crossAxisExtent = visitor(
      _crossAxisExtent,
      widget.crossAxisExtent,
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

    final crossAxisExtent =
        _crossAxisExtent?.evaluate(animation).clamp(0.0, double.infinity);

    final color = _color?.evaluate(animation);

    return Gap(
      mainAxisExtent ?? 0,
      crossAxisExtent: crossAxisExtent,
      color: color,
    );
  }
}
