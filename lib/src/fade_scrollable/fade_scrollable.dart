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

  /// Whether should be disposed the scroll controller
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

  late final FadeSideFactorChangeNotifier fadeSideFactorChangeNotifier;

  @override
  void initState() {
    super.initState();
    controller = widget.createController();
    controller.addListener(onPositionChanged);

    fadeSideFactorChangeNotifier = FadeSideFactorChangeNotifier(
      FadeSideFactorState(
        start: 0,
        end: widget.fadeDimensionFactor,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onPositionChanged();
    });
  }

  void onPositionChanged() {
    final viewport = controller.position.viewportDimension;
    final maxScrollExtent = controller.position.maxScrollExtent;
    if (viewport <= maxScrollExtent) {
      fadeSideFactorChangeNotifier.updateFadeFactor(
        start: 0,
        end: 0,
      );
      return;
    }
    final offset = controller.offset.clamp(0, maxScrollExtent);

    final startFactor = (offset.clamp(0, viewport) / viewport)
        .clamp(0.0, widget.fadeDimensionFactor);

    final endFactor = ((maxScrollExtent - offset).clamp(0, viewport) / viewport)
        .clamp(0.0, widget.fadeDimensionFactor);

    fadeSideFactorChangeNotifier.updateFadeFactor(
      start: startFactor,
      end: endFactor,
    );
  }

  @override
  void dispose() {
    controller.removeListener(onPositionChanged);
    if (widget.disposeController) controller.dispose();
    fadeSideFactorChangeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeShader(
      axis: widget.axis,
      fadeSideFactorChangeNotifier: fadeSideFactorChangeNotifier,
      shadeDimensionFactor: widget.fadeDimensionFactor,
      child: widget.scrollable(controller),
    );
  }
}
