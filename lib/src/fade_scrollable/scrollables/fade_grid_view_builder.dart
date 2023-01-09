import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:re_widgets/re_widgets.dart';

/// {@template re_seedwork.widgets.fadeGridViewBuilder}
/// [GridView.builder()], start and end of which are faded
/// {@endtemplate}
class FadeGridViewBuilder extends FadeScrollable {
  /// Creates a
  /// {@macro re_seedwork.widgets.fadeGridViewBuilder}
  FadeGridViewBuilder({
    super.key,
    super.axis,
    required SliverGridDelegate gridDelegate,
    required int itemCount,
    required Widget Function(BuildContext context, int index) itemBuilder,
    EdgeInsets padding = EdgeInsets.zero,
    ScrollController Function()? createController,
    super.disposeController,
    super.fadeDimensionFactor,
    bool reverse = false,
    String? restorationId,
    ScrollPhysics? physics,
    bool? primary,
    bool shrinkWrap = false,
    Clip clipBehavior = Clip.hardEdge,
    ChildIndexGetter? findChildIndexCallback,
    double? cacheExtent,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
  }) : super(
          createController: createController ?? ScrollController.new,
          scrollable: (controller) {
            return GridView.builder(
              padding: padding,
              controller: controller,
              scrollDirection: axis,
              gridDelegate: gridDelegate,
              itemCount: itemCount,
              itemBuilder: itemBuilder,
              reverse: reverse,
              primary: primary,
              physics: physics,
              shrinkWrap: shrinkWrap,
              findChildIndexCallback: findChildIndexCallback,
              addAutomaticKeepAlives: addAutomaticKeepAlives,
              addRepaintBoundaries: addRepaintBoundaries,
              addSemanticIndexes: addSemanticIndexes,
              cacheExtent: cacheExtent,
              semanticChildCount: semanticChildCount,
              dragStartBehavior: dragStartBehavior,
              keyboardDismissBehavior: keyboardDismissBehavior,
              restorationId: restorationId,
              clipBehavior: clipBehavior,
            );
          },
        );
}
