import 'package:flutter/material.dart';
import 'package:re_widgets/re_widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_app/utils/knobs.dart';

@UseCase(name: 'Default', type: FadePageViewBuilder)
Widget defaultFadePageViewBuilderUseCase(BuildContext context) {
  return FadePageViewBuilder(
    itemCount: context.itemsCountKnob(initial: 3),
    fadeDimensionFactor: context.sliderFadeFactorKnob(),
    axis: context.axisKnob,
    physics: context.scrollPhysicsKnob,
    itemBuilder: (context, index) => ColoredBox(
      color: index.isEven ? Colors.teal : Colors.blueAccent,
      child: Center(
        child: Text(
          '$index',
        ),
      ),
    ),
  );
}
