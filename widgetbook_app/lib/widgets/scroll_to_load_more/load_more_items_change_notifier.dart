part of 'scroll_to_load_more.dart';

typedef _LoadMoreItemsState = AsyncData<_ItemsState, Object>;

class _LoadMoreItemsChangeNotifier extends ValueNotifier<_LoadMoreItemsState> {
  // ignore: unused_element
  _LoadMoreItemsChangeNotifier({this.batchSize = 20})
      : super(const _LoadMoreItemsState.initial(_ItemsState.initial()));

  @protected
  final int batchSize;

  Future<void> loadMore() async {
    value = value.inLoading();

    await Future<void>.delayed(const Duration(milliseconds: 300));

    // return error
    if (Random().nextBool()) {
      value = value.inFailure();
      return;
    }

    value = _getItems();
  }

  AsyncData<_ItemsState, Object> _getItems({bool refresh = false}) {
    // Whether to return full batch, or not
    // (which means that there is no more items to load)
    final newBatchSize =
        Random().nextBool() ? Random().nextInt(batchSize) : batchSize;

    final items = [
      if (!refresh) ...value.payload.items,
      ...List.generate(newBatchSize, (index) {
        return (refresh ? 0 : value.payload.items.length) + index;
      })
    ];

    return AsyncData.success(
      _ItemsState(
        items: items,
        hasReachedMax: newBatchSize < batchSize,
      ),
    );
  }

  Future<void> refresh() async {
    value = const AsyncData.loading(_ItemsState.initial());

    await Future<void>.delayed(const Duration(milliseconds: 300));

    // return error
    if (Random().nextBool()) {
      value = value.inFailure();
      return;
    }

    value = _getItems(refresh: true);
  }
}
