import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

extension IntegerKnob on KnobsBuilder {
  int integer({
    required String label,
    String? description,
    int initial = 10,
  }) {
    return onKnobAdded(
      IntegerInputKnob(
        label: label,
        value: initial,
        description: description,
      ),
    )!;
  }
}

extension KnobsExtension on BuildContext {
  /// [initial] defaults to `0`
  double doubleKnob({
    required String label,
    double initial = 0,
    String? description,
  }) {
    return knobs.double.input(
      label: label,
      initialValue: initial,
      description: description,
    );
  }

  String stringKnob({
    required String label,
    String initial = '',
    String? description,
  }) {
    return knobs.string(
      label: label,
      description: description,
      initialValue: initial,
    );
  }

  int itemsCountKnob({int initial = 50}) {
    return knobs.integer(label: 'items count', initial: initial);
  }

  double sliderFadeFactorKnob({
    String label = 'Fade dimension factor',
    double min = 0,
    double max = .5,
    double initial = .05,
  }) {
    return knobs.double.slider(
      label: label,
      min: min,
      max: max,
      initialValue: initial,
    );
  }

  Axis get axisKnob {
    return knobs.list<Axis>(
      label: 'Axis',
      options: const [
        Axis.vertical,
        Axis.horizontal,
      ],
      labelBuilder: (value) => value.name,
    );
  }

  ScrollPhysics? get scrollPhysicsKnob {
    return knobs.listOrNull<ScrollPhysics>(
      label: 'Scroll physics',
      labelBuilder: (value) {
        return value.runtimeType.toString();
      },
      options: const [
        null,
        ClampingScrollPhysics(),
        BouncingScrollPhysics(),
        AlwaysScrollableScrollPhysics(),
        NeverScrollableScrollPhysics(),
        RangeMaintainingScrollPhysics(),
      ],
    );
  }
}

class IntegerInputKnob extends Knob<int> {
  IntegerInputKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields {
    return [
      IntegerInputField(
        name: label,
        initialValue: value,
        onChanged: (context, value) {
          if (value == null) return;
          WidgetbookState.of(context).knobs.updateValue(label, value);
        },
      ),
    ];
  }

  @override
  int valueFromQueryGroup(Map<String, String> group) {
    return group.containsKey(label) ? int.parse(group[label]!) : value;
  }
}

class IntegerInputField extends Field<int> {
  IntegerInputField({
    required super.name,
    super.initialValue = 0,
    super.onChanged,
  }) : super(
          type: FieldType.doubleSlider,
          codec: FieldCodec(
            toParam: (value) => value.toString(),
            toValue: (param) => int.tryParse(param ?? ''),
          ),
        );

  @override
  Widget toWidget(BuildContext context, String group, int? value) {
    return TextFormField(
      initialValue: codec.toParam(value ?? initialValue ?? 0),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        updateField(
          context,
          group,
          codec.toValue(value) ?? initialValue ?? 0,
        );
      },
    );
  }
}
