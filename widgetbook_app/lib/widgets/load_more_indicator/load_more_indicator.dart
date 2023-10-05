import 'package:flutter/widgets.dart';
import 'package:re_widgets/re_widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_app/utils/knobs.dart';
import 'package:widgetbook/widgetbook.dart';

@UseCase(name: 'Default', type: LoadMoreIndicator)
Widget buildLoadMoreIndicator(BuildContext context) {
  return LoadMoreIndicator(
    dotSize: context.doubleKnob(
      label: 'Dot size',
      initial: 10,
    ),
    dotsNumber: context.knobs.integer(
      label: 'Dots number',
      initial: 3,
    ),
    duration: Duration(
      milliseconds: context.knobs.integer(
        label: 'Animation duration',
        description: 'in milliseconds',
        initial: 500,
      ),
    ),
    paddingBetweenDots: context.doubleKnob(
      label: 'Padding between dots',
      initial: 5,
    ),
  );
}
