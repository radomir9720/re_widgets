import 'package:flutter/material.dart';

part 'enable_fade_side_change_notifier.dart';

/// Creates a fade [ShaderMask] on top of the [child]
class FadeShader extends StatelessWidget {
  ///
  const FadeShader({
    super.key,
    required this.axis,
    required this.child,
    required this.enableFadeSideChangeNotifier,
    this.shadeDimensionFactor = kDefaultFadeDimensionFactor,
  });

  /// Creates a vertical fade shade
  /// (the fade effect will be on the top and the bottom)
  factory FadeShader.vertical({
    Key? key,
    required Widget child,
    required EnableFadeSideChangeNotifier enableFadeSideChangeNotifier,
    double shadeDimensionFactor = kDefaultFadeDimensionFactor,
  }) =>
      FadeShader(
        key: key,
        enableFadeSideChangeNotifier: enableFadeSideChangeNotifier,
        shadeDimensionFactor: shadeDimensionFactor,
        axis: Axis.vertical,
        child: child,
      );

  /// Creates a vertical fade shade
  /// (the fade effect will be on the left and the right)
  factory FadeShader.horizontal({
    Key? key,
    required Widget child,
    required EnableFadeSideChangeNotifier enableFadeSideChangeNotifier,
    double shadeDimensionFactor = kDefaultFadeDimensionFactor,
  }) =>
      FadeShader(
        key: key,
        enableFadeSideChangeNotifier: enableFadeSideChangeNotifier,
        shadeDimensionFactor: shadeDimensionFactor,
        axis: Axis.horizontal,
        child: child,
      );

  /// Default shade dimension factor
  static const kDefaultFadeDimensionFactor = .05;

  /// The child. Widget, on top of which will be placed the fade effect
  @protected
  final Widget child;

  /// {@template re_seedwork.widgets.fadeShader.shadeDimensionFactor}
  /// Which part of the widget should be faded
  /// {@endtemplate}
  @protected
  final double shadeDimensionFactor;

  /// ValueNotifier, which notifies when [EnableFadeSideState] changes
  @protected
  final EnableFadeSideChangeNotifier enableFadeSideChangeNotifier;

  /// {@template re_seedwork.widgets.fadeShader.axis}
  /// Axis of the fade effect
  /// {@endtemplate}
  @protected
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<EnableFadeSideState>(
      valueListenable: enableFadeSideChangeNotifier,
      builder: (context, state, child) {
        return state.bothDisabled
            ? const SizedBox.shrink()
            : ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: axis == Axis.vertical
                        ? Alignment.topCenter
                        : Alignment.centerLeft,
                    end: axis == Axis.vertical
                        ? Alignment.bottomCenter
                        : Alignment.centerRight,
                    stops: [
                      if (state.enableStart) .0,
                      shadeDimensionFactor,
                      1 - shadeDimensionFactor,
                      if (state.enableEnd) 1,
                    ],
                    colors: [
                      if (state.enableStart) Colors.transparent,
                      Colors.black,
                      Colors.black,
                      if (state.enableEnd) Colors.transparent,
                    ],
                  ).createShader(Offset.zero & Size(rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: child,
              );
      },
      child: child,
    );
  }
}
