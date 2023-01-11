import 'package:flutter/material.dart';
import 'package:re_widgets/re_widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_app/utils/knobs.dart';

@WidgetbookUseCase(name: 'Default', type: FadeSingleChildScrollView)
Widget defaultFadeSingleChildScrollViewUseCase(BuildContext context) {
  return FadeSingleChildScrollView(
    fadeDimensionFactor: context.sliderFadeFactorKnob(),
    axis: context.axisKnob,
    physics: context.scrollPhysicsKnob,
    child: Column(
      children: List.generate(
        context.itemsCountKnob(),
        (index) => SizedBox(
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
      ),
    ),
  );
}
