part of 'scroll_to_load_more.dart';

abstract class _LoadMoreItemsState {
  const _LoadMoreItemsState(this.payload);

  final _ItemsState payload;

  bool get isFailure => this is _FailureLoadMoreItemsState;

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function() failure,
    required R Function() success,
  });
}

class _InitialLoadMoreItemsState extends _LoadMoreItemsState {
  const _InitialLoadMoreItemsState(super.payload);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function() failure,
    required R Function() success,
  }) {
    return initial();
  }
}

class _LoadingLoadMoreItemsState extends _LoadMoreItemsState {
  const _LoadingLoadMoreItemsState(super.payload);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function() failure,
    required R Function() success,
  }) {
    return loading();
  }
}

class _FailureLoadMoreItemsState extends _LoadMoreItemsState {
  const _FailureLoadMoreItemsState(super.payload);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function() failure,
    required R Function() success,
  }) {
    return failure();
  }
}

class _SuccessLoadMoreItemsState extends _LoadMoreItemsState {
  const _SuccessLoadMoreItemsState(super.payload);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function() failure,
    required R Function() success,
  }) {
    return success();
  }
}

class _LoadMoreItemsChangeNotifier extends ValueNotifier<_LoadMoreItemsState> {
  // ignore: unused_element
  _LoadMoreItemsChangeNotifier({this.batchSize = 20})
      : super(const _InitialLoadMoreItemsState(_ItemsState.initial()));

  @protected
  final int batchSize;

  Future<void> loadMore() async {
    value = _LoadingLoadMoreItemsState(value.payload);

    await Future<void>.delayed(const Duration(milliseconds: 300));

    // return error
    if (Random().nextBool()) {
      value = _FailureLoadMoreItemsState(value.payload);
      return;
    }

    value = _getItems();
  }

  _LoadMoreItemsState _getItems({bool refresh = false}) {
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

    return _SuccessLoadMoreItemsState(
      _ItemsState(
        items: items,
        hasReachedMax: newBatchSize < batchSize,
      ),
    );
  }

  Future<void> refresh() async {
    value = const _LoadingLoadMoreItemsState(_ItemsState.initial());

    await Future<void>.delayed(const Duration(milliseconds: 300));

    // return error
    if (Random().nextBool()) {
      value = _FailureLoadMoreItemsState(value.payload);
      return;
    }

    value = _getItems(refresh: true);
  }
}
