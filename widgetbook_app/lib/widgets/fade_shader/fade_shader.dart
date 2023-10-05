import 'package:flutter/material.dart';
import 'package:re_widgets/re_widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_app/utils/knobs.dart';

@UseCase(name: 'Default', type: FadeShader)
Widget buildFadeShader(BuildContext context) {
  return FadeShader(
    axis: context.axisKnob,
    fadeSideFactorChangeNotifier: FadeSideFactorChangeNotifier(
      FadeSideFactorState(
        start: context.sliderFadeFactorKnob(
          label: 'Start fade dimension factor',
        ),
        end: context.sliderFadeFactorKnob(
          label: 'End fade dimension factor',
        ),
      ),
    ),
    child: const SizedBox.expand(
      child: ColoredBox(color: Colors.amber),
    ),
  );
}
