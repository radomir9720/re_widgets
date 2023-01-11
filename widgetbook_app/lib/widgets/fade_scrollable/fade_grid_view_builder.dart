import 'package:flutter/material.dart';
import 'package:re_widgets/re_widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_app/utils/knobs.dart';

@WidgetbookUseCase(name: 'Default', type: FadeGridViewBuilder)
Widget defaultFadeGridViewBuilderUseCase(BuildContext context) {
  return FadeGridViewBuilder(
    itemCount: context.itemsCountKnob(),
    padding: const EdgeInsets.all(16),
    fadeDimensionFactor: context.sliderFadeFactorKnob(),
    axis: context.axisKnob,
    physics: context.scrollPhysicsKnob,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisExtent: 50,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
    ),
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
