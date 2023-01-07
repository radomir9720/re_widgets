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
    required Widget Function(BuildContext context, int index) itemBuilder,
    ScrollController Function()? createController,
    super.axis,
    super.disposeController,
    super.fadeDimensionFactor,
  }) : super(
          createController: createController ?? ScrollController.new,
          scrollable: (controller) {
            return ListView.builder(
              controller: controller,
              scrollDirection: axis,
              itemCount: itemCount,
              itemBuilder: itemBuilder,
            );
          },
        );
}
