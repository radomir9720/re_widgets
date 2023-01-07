import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// {@template re_seedwork.widgets.avoidBottomInsetWidget}
///
/// Observes the bottom safe area and bottom inset(keyboard appearance)
/// and creates an invisible widget, height of which changes with animation.
/// {@endtemplate}
///
/// The height of this widget will be equal to
/// the bottom inset or bottom safa area, whichever is bigger.
class AvoidBottomInsetWidget extends StatefulWidget {
  /// Creates a widget, that
  /// {@macro re_seedwork.widgets.avoidBottomInsetWidget}
  ///
  /// [animationDuration] by default equals to [kDefaultAnimationDuration]
  ///
  /// [curve] defaults to [Curves.linear]
  const AvoidBottomInsetWidget({
    super.key,
    this.onEnd,
    this.curve = Curves.linear,
    this.animationDuration = kDefaultAnimationDuration,
  });

  /// The curve for animation
  @protected
  final Curve curve;

  /// The animation duration
  @protected
  final Duration animationDuration;

  /// A function, that will be called on animation end
  @protected
  final VoidCallback? onEnd;

  /// Yhe default animation duration
  @protected
  static const kDefaultAnimationDuration = Duration(milliseconds: 150);

  @override
  State<AvoidBottomInsetWidget> createState() => _AvoidBottomInsetWidgetState();
}

class _AvoidBottomInsetWidgetState extends State<AvoidBottomInsetWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() => setState(() {});

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      onEnd: widget.onEnd,
      curve: widget.curve,
      duration: widget.animationDuration,
      padding: EdgeInsets.only(bottom: math.max(bottomInset, bottomSafeArea)),
    );
  }
}
