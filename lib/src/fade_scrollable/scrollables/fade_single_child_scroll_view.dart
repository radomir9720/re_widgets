import 'package:flutter/widgets.dart';
import 'package:re_widgets/re_widgets.dart';

/// {@template re_seedwork.widgets.fadeSingleChildScrollView}
/// [SingleChildScrollView], start and end of which are faded
/// {@endtemplate}
class FadeSingleChildScrollView extends FadeScrollable {
  /// Creates a
  /// {@macro re_seedwork.widgets.fadeSingleChildScrollView}
  FadeSingleChildScrollView({
    super.key,
    required Widget child,
    ScrollController Function()? createController,
    super.disposeController,
    super.axis,
    super.fadeDimensionFactor,
  }) : super(
          createController: createController ?? ScrollController.new,
          scrollable: (controller) {
            return SingleChildScrollView(
              controller: controller,
              scrollDirection: axis,
              child: child,
            );
          },
        );
}
