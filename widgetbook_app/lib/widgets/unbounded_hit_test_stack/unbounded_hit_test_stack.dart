import 'package:flutter/material.dart';
import 'package:re_widgets/re_widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: UnboundedHitTestStack)
Widget buildUnboundedHitTestStack(BuildContext context) {
  final children = [
    const SizedBox.square(
      dimension: 100,
      child: ColoredBox(color: Colors.amber),
    ),
    Positioned(
      left: -30,
      top: -30,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pressed!'),
            ),
          );
        },
        child: SizedBox.square(
          dimension: 50,
          child: ColoredBox(
            color: Colors.green.withOpacity(.5),
            child: const Center(
              child: Text(
                'Press me',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    ),
  ];

  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('UnboundedHitTestStack:'),
          const SizedBox(height: 30),
          UnboundedHitTestStack(
            clipBehavior: Clip.none,
            children: children,
          ),
          const SizedBox(height: 30),
          const Text('Stack:'),
          const SizedBox(height: 30),
          Stack(
            clipBehavior: Clip.none,
            children: children,
          ),
        ],
      ),
    ),
  );
}
