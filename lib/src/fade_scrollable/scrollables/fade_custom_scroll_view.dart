import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:re_widgets/re_widgets.dart';

/// {@template re_seedwork.widgets.fadeCustomScrollView}
/// [CustomScrollView()], start and end of which are faded
/// {@endtemplate}
class FadeCustomScrollView extends FadeScrollable<ScrollController> {
  /// Creates a
  /// {@macro re_seedwork.widgets.fadeCustomScrollView}
  FadeCustomScrollView({
    super.key,
    ScrollController Function()? createController,
    required List<Widget> slivers,
    super.axis,
    super.disposeController,
    super.fadeDimensionFactor,
    bool reverse = false,
    String? restorationId,
    ScrollPhysics? physics,
    bool? primary,
    bool shrinkWrap = false,
    Clip clipBehavior = Clip.hardEdge,
    double? cacheExtent,
    double anchor = 0,
    int? semanticChildCount,
    Key? center,
    ScrollBehavior? scrollBehavior,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
  }) : super(
          createController: createController ?? ScrollController.new,
          scrollable: (controller) {
            return CustomScrollView(
              controller: controller,
              scrollDirection: axis,
              reverse: reverse,
              primary: primary,
              physics: physics,
              shrinkWrap: shrinkWrap,
              cacheExtent: cacheExtent,
              semanticChildCount: semanticChildCount,
              dragStartBehavior: dragStartBehavior,
              keyboardDismissBehavior: keyboardDismissBehavior,
              restorationId: restorationId,
              clipBehavior: clipBehavior,
              anchor: anchor,
              center: center,
              scrollBehavior: scrollBehavior,
              slivers: slivers,
            );
          },
        );
}
