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
            );
          },
        );
}
