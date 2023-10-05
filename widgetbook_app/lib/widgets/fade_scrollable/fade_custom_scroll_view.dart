import 'package:flutter/material.dart';
import 'package:re_widgets/re_widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_app/utils/knobs.dart';

@UseCase(name: 'Default', type: FadeCustomScrollView)
Widget defaultFadeCustomScrollViewUseCase(BuildContext context) {
  return FadeCustomScrollView(
    fadeDimensionFactor: context.sliderFadeFactorKnob(),
    axis: context.axisKnob,
    physics: context.scrollPhysicsKnob,
    slivers: [
      SliverList.builder(
        itemCount: context.itemsCountKnob(),
        itemBuilder: (context, index) {
          return SizedBox(
            height: 50,
            child: ColoredBox(
              color: index.isEven ? Colors.teal : Colors.blueAccent,
              child: Center(
                child: Text(
                  '$index',
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}
