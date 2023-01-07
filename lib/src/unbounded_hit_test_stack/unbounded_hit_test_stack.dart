import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// {@template re_seedwork.widgets.unboundedHitTestStack}
/// [Stack] with one difference: handles tap/press events outside its bounds
/// {@endtemplate}
class UnboundedHitTestStack extends Stack {
  /// Creates a
  /// {@macro re_seedwork.widgets.unboundedHitTestStack}
  UnboundedHitTestStack({
    super.key,
    super.alignment,
    super.textDirection,
    super.fit,
    super.clipBehavior,
    super.children,
  });

  @override
  RenderStack createRenderObject(BuildContext context) {
    return _UnboundedHitTestRenderStack(
      alignment: alignment,
      textDirection: textDirection ?? Directionality.of(context),
      fit: fit,
      clipBehavior: clipBehavior,
    );
  }
}

class _UnboundedHitTestRenderStack extends RenderStack {
  _UnboundedHitTestRenderStack({
    super.alignment,
    super.textDirection,
    super.fit,
    super.clipBehavior,
  });

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (hitTestChildren(result, position: position) || hitTestSelf(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }
}
