part of 'scroll_to_load_more.dart';

/// {@template re_seedwork.widgets.scrollToLoadMore.state}
/// Enum, which contains info about the current loading state
/// {@endtemplate}
enum ScrollToLoadMoreState {
  /// Initial state. [ScrollToLoadMoreState] was just instansiated,
  /// and there was no attempts to load more batches
  initial,

  /// Attempting to load a batch. Waiting for response(success, or failure)
  loading,

  /// Attempt to load a batch was unsucessful for some reason
  failure,

  /// Successfully loaded a new batch
  success;

  /// Returns `true` if the current state equals to
  /// [ScrollToLoadMoreState.initial], otherwise - `false`
  bool get isInitial => this == ScrollToLoadMoreState.initial;

  /// Returns `true` if the current state equals to
  /// [ScrollToLoadMoreState.loading], otherwise - `false`
  bool get isLoading => this == ScrollToLoadMoreState.loading;

  /// Returns `true` if the current state equals to
  /// [ScrollToLoadMoreState.failure], otherwise - `false`
  bool get isFailure => this == ScrollToLoadMoreState.failure;

  /// Returns `true` if the current state equals to
  /// [ScrollToLoadMoreState.success], otherwise - `false`
  bool get isSuccess => this == ScrollToLoadMoreState.success;

  /// Pattern matching function by type. Executes the corresponding to the type
  /// callback, and returns the result of it.
  ///
  /// `orElse` callback is executed and its result is returned if the
  /// corresponding to the type callback was not specified.
  R maybeWhen<R>({
    required R Function() orElse,
    R Function()? initial,
    R Function()? loading,
    R Function()? failure,
    R Function()? success,
  }) {
    switch (this) {
      case ScrollToLoadMoreState.initial:
        return initial?.call() ?? orElse();
      case ScrollToLoadMoreState.loading:
        return loading?.call() ?? orElse();
      case ScrollToLoadMoreState.failure:
        return failure?.call() ?? orElse();
      case ScrollToLoadMoreState.success:
        return success?.call() ?? orElse();
    }
  }
}
