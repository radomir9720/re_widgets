import 'package:flutter/widgets.dart';
import 'package:re_widgets/re_widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_app/utils/knobs.dart';

@WidgetbookUseCase(name: 'Default', type: LoadMoreIndicator)
Widget buildLoadMoreIndicator(BuildContext context) {
  return Center(
    child: LoadMoreIndicator(
      dotSize: context.doubleKnob(
        label: 'Dot size',
        initial: 10,
      ),
      dotsNumber: context.intKnob(
        label: 'Dots number',
        initial: 3,
      ),
      duration: Duration(
        milliseconds: context.intKnob(
          label: 'Animation duration',
          description: 'in milliseconds',
          initial: 500,
        ),
      ),
      paddingBetweenDots: context.doubleKnob(
        label: 'Padding between dots',
        initial: 5,
      ),
    ),
  );
}
