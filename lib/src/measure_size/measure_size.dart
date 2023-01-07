import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// void Function(Size size)
typedef OnWidgetSizeChange = void Function(Size size);

/// {@template re_seedwork.widgets.measureSizeRenderObject}
/// Render object for determining the size of a widget
/// {@endtemplate}
class MeasureSizeRenderObject extends RenderProxyBox {
  /// Creates a
  /// {@macro re_seedwork.widgets.measureSizeRenderObject}
  MeasureSizeRenderObject(this.onChange);

  /// The old size of a widget
  @protected
  Size? oldSize;

  /// {@template re_seedwork.widgets.measureSizeRenderObject.onChange}
  /// Callback, which will be called when size has been changed
  /// {@endtemplate}
  @protected
  final OnWidgetSizeChange onChange;

  @override
  void performLayout() {
    super.performLayout();

    final newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

/// {@template re_seedwork.widgets.measureSize}
/// Widget for determining the size of its [child]
/// {@endtemplate}
class MeasureSize extends SingleChildRenderObjectWidget {
  /// Creates a
  /// {@macro re_seedwork.widgets.measureSize}
  const MeasureSize({
    super.key,
    required this.onChange,
    required super.child,
  });

  /// {@macro re_seedwork.widgets.measureSizeRenderObject.onChange}
  @protected
  final OnWidgetSizeChange onChange;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }
}
