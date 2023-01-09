import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:re_widgets/re_widgets.dart';

/// {@template re_seedwork.widgets.fadePageViewBuilder}
/// [PageView.builder()], start and end of which are faded
/// {@endtemplate}
class FadePageViewBuilder extends FadeScrollable<PageController> {
  /// Creates a
  /// {@macro re_seedwork.widgets.fadePageViewBuilder}
  FadePageViewBuilder({
    super.key,
    bool padEnds = true,
    bool reverse = false,
    String? restorationId,
    ScrollPhysics? physics,
    required int itemCount,
    super.disposeController,
    super.fadeDimensionFactor,
    bool pageSnapping = true,
    super.axis = Axis.horizontal,
    ScrollBehavior? scrollBehavior,
    Clip clipBehavior = Clip.hardEdge,
    void Function(int)? onPageChanged,
    bool allowImplicitScrolling = false,
    ChildIndexGetter? findChildIndexCallback,
    required IndexedWidgetBuilder itemBuilder,
    PageController Function()? createController,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
  }) : super(
          createController: createController ?? PageController.new,
          scrollable: (controller) => PageView.builder(
            padEnds: padEnds,
            reverse: reverse,
            physics: physics,
            itemCount: itemCount,
            scrollDirection: axis,
            controller: controller,
            itemBuilder: itemBuilder,
            clipBehavior: clipBehavior,
            pageSnapping: pageSnapping,
            restorationId: restorationId,
            onPageChanged: onPageChanged,
            scrollBehavior: scrollBehavior,
            dragStartBehavior: dragStartBehavior,
            findChildIndexCallback: findChildIndexCallback,
            allowImplicitScrolling: allowImplicitScrolling,
          ),
        );
}
