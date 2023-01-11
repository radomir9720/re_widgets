import 'package:flutter/material.dart';
import 'package:re_widgets/re_widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_app/utils/knobs.dart';

@WidgetbookUseCase(name: 'Default', type: MeasureSize)
Widget buildMeasureSize(BuildContext context) {
  return const _MeasureSizeWidget();
}

class _MeasureSizeWidget extends StatefulWidget {
  const _MeasureSizeWidget({Key? key}) : super(key: key);

  @override
  State<_MeasureSizeWidget> createState() => __MeasureSizeWidgetState();
}

class __MeasureSizeWidgetState extends State<_MeasureSizeWidget> {
  final sizeChangeNotifier = ValueNotifier(Size.zero);

  @override
  void dispose() {
    sizeChangeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MeasureSize(
        onChange: (newSize) => sizeChangeNotifier.value = newSize,
        child: SizedBox(
          width: context.doubleKnob(
            label: 'width',
            initial: 100,
          ),
          height: context.doubleKnob(
            label: 'height',
            initial: 100,
          ),
          child: ColoredBox(
            color: Colors.green,
            child: Center(
              child: ValueListenableBuilder<Size>(
                valueListenable: sizeChangeNotifier,
                builder: (context, value, child) {
                  return Text(
                    '$value',
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
