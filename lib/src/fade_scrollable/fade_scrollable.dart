import 'package:flutter/widgets.dart';
import 'package:re_widgets/re_widgets.dart';

/// {@template re_seedwork.widgets.fadeScrollable}
/// A scrollable view, that has a fade effect on its start and end.
/// {@endtemplate}
class FadeScrollable<T extends ScrollController> extends StatefulWidget {
  /// Creates
  /// {@macro re_seedwork.widgets.fadeScrollable}
  const FadeScrollable({
    super.key,
    this.axis = Axis.vertical,
    required this.scrollable,
    required this.createController,
    this.disposeController = true,
    this.fadeDimensionFactor = FadeShader.kDefaultFadeDimensionFactor,
  });

  /// {@macro re_seedwork.widgets.fadeShader.axis}
  @protected
  final Axis axis;

  /// Builder, that returns scrollable widget
  @protected
  final Widget Function(T controller) scrollable;

  /// Function, that should return controller
  @protected
  final T Function() createController;

  /// Wheter should be disposed the scroll controller
  @protected
  final bool disposeController;

  /// {@macro re_seedwork.widgets.fadeShader.shadeDimensionFactor}
  @protected
  final double fadeDimensionFactor;

  @override
  State<FadeScrollable<T>> createState() => _FadeScrollableState<T>();
}

class _FadeScrollableState<T extends ScrollController>
    extends State<FadeScrollable<T>> {
  late final T controller;

  final enableFadeSideChangeNotifier = EnableFadeSideChangeNotifier(
    const EnableFadeSideState(
      enableStart: false,
      enableEnd: true,
    ),
  );

  @override
  void initState() {
    super.initState();
    controller = widget.createController();
    controller.addListener(onPositionChanged);
  }

  void onPositionChanged() {
    final enableStart = enableFadeSideChangeNotifier.value.enableStart;
    final enableEnd = enableFadeSideChangeNotifier.value.enableEnd;

    if (controller.offset <= 0) {
      if (enableStart) enableFadeSideChangeNotifier.update(enableStart: false);
    } else if (controller.offset >= controller.position.maxScrollExtent) {
      if (enableEnd) enableFadeSideChangeNotifier.update(enableEnd: false);
    } else {
      if (!enableStart || !enableEnd) {
        enableFadeSideChangeNotifier
          ..update(enableStart: true)
          ..update(enableEnd: true);
      }
    }
  }

  @override
  void dispose() {
    controller.removeListener(onPositionChanged);
    if (widget.disposeController) controller.dispose();
    enableFadeSideChangeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeShader(
      axis: widget.axis,
      enableFadeSideChangeNotifier: enableFadeSideChangeNotifier,
      shadeDimensionFactor: widget.fadeDimensionFactor,
      child: widget.scrollable(controller),
    );
  }
}
