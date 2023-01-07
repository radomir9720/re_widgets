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
    required int itemCount,
    required Widget Function(BuildContext context, int index) itemBuilder,
    PageController Function()? createController,
    super.axis = Axis.horizontal,
    bool padEnds = true,
    super.disposeController,
    super.fadeDimensionFactor,
  }) : super(
          createController: createController ?? PageController.new,
          scrollable: (controller) => PageView.builder(
            controller: controller,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            scrollDirection: axis,
            padEnds: padEnds,
          ),
        );
}
