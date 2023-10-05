import 'package:flutter/material.dart';
import 'package:re_widgets/re_widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_app/utils/knobs.dart';

@UseCase(name: 'Default', type: PageViewIndicator)
Widget defaultPageViewIndicatorUseCase(BuildContext context) {
  return const _PageViewIndicatorWidget();
}

class _PageViewIndicatorWidget extends StatefulWidget {
  const _PageViewIndicatorWidget();

  @override
  State<_PageViewIndicatorWidget> createState() =>
      _PageViewIndicatorWidgetState();
}

class _PageViewIndicatorWidgetState extends State<_PageViewIndicatorWidget> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pagesCount = context.knobs.integer(
      label: 'Pages count',
      initial: 3,
    );
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: pagesCount,
            controller: pageController,
            itemBuilder: (context, index) {
              return ColoredBox(
                color: Colors.primaries[index % Colors.primaries.length],
                child: Center(child: Text('Page: $index')),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: PageViewIndicator(
            pageController: pageController,
            count: pagesCount,
            inactiveDotDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              color: Color.fromRGBO(200, 200, 201, 1),
            ),
            activeDotDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              color: Color.fromRGBO(109, 114, 120, 1),
            ),
            dotSize: Size(
              context.doubleKnob(label: 'Dot width', initial: 7),
              context.doubleKnob(label: 'Dot height', initial: 7),
            ),
            gap: context.doubleKnob(label: 'Gap', initial: 4),
          ),
        ),
      ],
    );
  }
}
