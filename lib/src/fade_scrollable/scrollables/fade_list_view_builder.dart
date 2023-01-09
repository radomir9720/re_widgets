import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:re_widgets/re_widgets.dart';

/// {@template re_seedwork.widgets.fadeListViewBuilder}
/// [ListView.builder()], start and end of which are faded
/// {@endtemplate}
class FadeListViewBuilder extends FadeScrollable<ScrollController> {
  /// Creates a
  /// {@macro re_seedwork.widgets.fadeListViewBuilder}
  FadeListViewBuilder({
    super.key,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    ScrollController Function()? createController,
    super.axis,
    super.disposeController,
    super.fadeDimensionFactor,
    bool reverse = false,
    String? restorationId,
    ScrollPhysics? physics,
    bool? primary,
    bool shrinkWrap = false,
    Clip clipBehavior = Clip.hardEdge,
    ChildIndexGetter? findChildIndexCallback,
    EdgeInsets? padding,
    double? itemExtent,
    double? cacheExtent,
    Widget? prototypeItem,
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
            return ListView.builder(
              controller: controller,
              scrollDirection: axis,
              itemCount: itemCount,
              itemBuilder: itemBuilder,
              reverse: reverse,
              primary: primary,
              physics: physics,
              shrinkWrap: shrinkWrap,
              padding: padding,
              itemExtent: itemExtent,
              prototypeItem: prototypeItem,
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
