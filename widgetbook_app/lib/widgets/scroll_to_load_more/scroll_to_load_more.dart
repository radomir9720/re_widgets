import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:re_widgets/re_widgets.dart';

part 'load_more_items_change_notifier.dart';
part 'items_state.dart';

@UseCase(name: 'Default', type: ScrollToLoadMore)
Widget buildScrollToLoadMore(BuildContext context) {
  return const _ScrollToLoadMoreExample();
}

class _ScrollToLoadMoreExample extends StatefulWidget {
  const _ScrollToLoadMoreExample({Key? key}) : super(key: key);

  @override
  State<_ScrollToLoadMoreExample> createState() =>
      _ScrollToLoadMoreExampleState();
}

class _ScrollToLoadMoreExampleState extends State<_ScrollToLoadMoreExample> {
  final loadMoreChangeNotifier = _LoadMoreItemsChangeNotifier();

  @override
  void initState() {
    loadMoreChangeNotifier.loadMore();
    super.initState();
  }

  @override
  void dispose() {
    loadMoreChangeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<_LoadMoreItemsState>(
          valueListenable: loadMoreChangeNotifier,
          builder: (context, state, child) {
            final payload = state.payload;
            final items = payload.items;
            if (items.isEmpty) {
              return Center(
                child: state.isFailure
                    ? _FailureWidget(
                        onPressed: loadMoreChangeNotifier.loadMore,
                      )
                    : const CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                ListTile(
                  title: const Text('has reached max:'),
                  trailing: Text(payload.hasReachedMax.toString()),
                ),
                TextButton(
                  onPressed: loadMoreChangeNotifier.refresh,
                  child: const Text('refresh'),
                ),
                Expanded(
                  child: ScrollToLoadMore(
                    loadingIndicator: const LoadMoreIndicator(),
                    failureWidget: _FailureWidget(
                      onPressed: loadMoreChangeNotifier.loadMore,
                    ),
                    hasReachedMax: payload.hasReachedMax,
                    onTriggered: loadMoreChangeNotifier.loadMore,
                    state: state.when(
                      initial: () => ScrollToLoadMoreState.initial,
                      loading: () => ScrollToLoadMoreState.loading,
                      success: () => ScrollToLoadMoreState.success,
                      failure: () => ScrollToLoadMoreState.failure,
                    ),
                    scrollableBuilder: (bottom) {
                      return ListView.builder(
                        itemCount: items.length + 1,
                        itemBuilder: (context, index) => index == items.length
                            ? bottom
                            : Material(
                                child: ListTile(
                                  title: Text(items[index].toString()),
                                  tileColor: index.isEven
                                      ? Colors.teal
                                      : Colors.amberAccent,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class _FailureWidget extends StatelessWidget {
  const _FailureWidget({Key? key, required this.onPressed}) : super(key: key);

  @protected
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Error!'),
        TextButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.refresh),
          label: const Text('Try again'),
        ),
      ],
    );
  }
}
