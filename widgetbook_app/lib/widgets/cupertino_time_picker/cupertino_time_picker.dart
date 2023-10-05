import 'package:flutter/material.dart';
import 'package:re_widgets/re_widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: CupertinoHourMinutePicker)
Widget defaultCupertinoTimePickerUseCase(BuildContext context) => Center(
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return CupertinoHourMinutePicker(
                initialTime: ExtendedDateTime.fromDateTime(DateTime.now()),
              );
            },
          );
        },
        child: const Text('Open picker'),
      ),
    );
