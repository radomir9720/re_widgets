import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

extension KnobsExtension on BuildContext {
  /// [initial] defaults to `0`
  int intKnob({
    required String label,
    int initial = 0,
    String? description,
  }) {
    return knobs
        .number(
          label: label,
          initialValue: initial,
          description: description,
        )
        .toInt();
  }

  /// [initial] defaults to `0`
  double doubleKnob({
    required String label,
    double initial = 0,
    String? description,
  }) {
    return knobs
        .number(
          label: label,
          initialValue: initial,
          description: description,
        )
        .toDouble();
  }

  String stringKnob({
    required String label,
    String initial = '',
    String? description,
  }) {
    return knobs.text(
      label: label,
      description: description,
      initialValue: initial,
    );
  }

  int itemsCountKnob({int initial = 50}) {
    return intKnob(label: 'items count', initial: initial);
  }

  double sliderFadeFactorKnob({
    String label = 'Fade dimension factor',
    double min = 0,
    double max = .5,
    double initial = .05,
  }) {
    return knobs.slider(
      label: label,
      min: min,
      max: max,
      initialValue: initial,
    );
  }

  Axis get axisKnob {
    return knobs.options(
      label: 'Axis',
      options: const [
        Option(
          label: 'Vertical',
          value: Axis.vertical,
        ),
        Option(
          label: 'Horizontal',
          value: Axis.horizontal,
        ),
      ],
    );
  }

  ScrollPhysics? get scrollPhysicsKnob {
    return knobs.options(
      label: 'Scroll physics',
      options: const [
        Option(
          label: 'Null',
          value: null,
        ),
        Option(
          label: 'ClampingScrollPhysics',
          value: ClampingScrollPhysics(),
        ),
        Option(
          label: 'BouncingScrollPhysics',
          value: BouncingScrollPhysics(),
        ),
        Option(
          label: 'AlwaysScrollableScrollPhysics',
          value: AlwaysScrollableScrollPhysics(),
        ),
        Option(
          label: 'NeverScrollableScrollPhysics',
          value: NeverScrollableScrollPhysics(),
        ),
        Option(
          label: 'RangeMaintainingScrollPhysics',
          value: RangeMaintainingScrollPhysics(),
        ),
      ],
    );
  }
}
