import 'package:flutter/material.dart';
import 'package:re_widgets/re_widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
// import 'package:widgetbook/widgetbook.dart' show Knobs, Option;
import 'package:widgetbook_app/utils/knobs.dart';

@UseCase(name: 'Default', type: FadeListViewBuilder)
Widget defaultFadeListViewBuilderUseCase(BuildContext context) {
  return FadeListViewBuilder(
    itemCount: context.itemsCountKnob(),
    fadeDimensionFactor: context.sliderFadeFactorKnob(),
    axis: context.axisKnob,
    physics: context.scrollPhysicsKnob,
    itemBuilder: (context, index) => SizedBox(
      height: 50,
      child: ColoredBox(
        color: index.isEven ? Colors.teal : Colors.blueAccent,
        child: Center(
          child: Text(
            '$index',
          ),
        ),
      ),
    ),
  );
}
