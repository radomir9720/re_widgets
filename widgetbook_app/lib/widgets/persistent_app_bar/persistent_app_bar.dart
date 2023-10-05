import 'package:flutter/material.dart';
import 'package:re_widgets/re_widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_app/utils/knobs.dart';
import 'package:widgetbook_app/utils/string.dart';
import 'package:widgetbook/widgetbook.dart';

@UseCase(name: 'Default', type: PersistentAppBar)
Widget buildPersistentAppBar(BuildContext context) {
  return Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: context.knobs.boolean(label: 'Pinned', initialValue: true),
          floating:
              context.knobs.boolean(label: 'Floating', initialValue: false),
          delegate: PersistentAppBar(
            largeTitle: context
                .stringKnob(
                  label: 'Large Title',
                  initial: 'Screen Title',
                )
                .notEmptyOrNull,
            title: context
                .stringKnob(
                  label: 'Title',
                  initial: 'Screen Title',
                )
                .notEmptyOrNull,
            flexibleSpaceOptions: FlexibleSpaceOptions(
              height: context.doubleKnob(
                label: 'Flexible space height',
                initial: 60,
              ),
              mode: context.knobs.list(
                label: '',
                labelBuilder: (value) {
                  return value.name;
                },
                options: const [
                  FlexibleSpaceMode.useToolbar,
                  FlexibleSpaceMode.useSafeAreaAndToolbar,
                  FlexibleSpaceMode.none,
                ],
              ),
            ),
            largeTitlePadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            appBarCollapsedColor: Theme.of(context).colorScheme.background,
            leading: context.knobs.boolean(
              label: 'Show leading',
              initialValue: true,
            )
                ? BackButton(
                    onPressed: () {},
                    color: Theme.of(context).appBarTheme.iconTheme?.color,
                  )
                : null,
            flexibleSpace: context.knobs.boolean(
              label: 'Pass placeholder to flexibleSpace',
              initialValue: false,
            )
                ? Placeholder(
                    fallbackHeight: context.doubleKnob(
                      label: 'Placeholder height',
                      description: 'Works only when '
                          '"Pass placeholder to flexibleSpace" is true',
                      initial: 200,
                    ),
                  )
                : null,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                title: Text('Item no. $index'),
                tileColor: index.isEven ? Colors.teal : Colors.amberAccent,
              );
            },
            childCount: 100,
          ),
        )
      ],
    ),
  );
}
