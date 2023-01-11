part of 'scroll_to_load_more.dart';

@immutable
class _ItemsState {
  final List<int> items;

  final bool hasReachedMax;

  const _ItemsState({required this.items, required this.hasReachedMax});

  const _ItemsState.initial()
      : items = const [],
        hasReachedMax = false;

  _ItemsState copyWith({
    List<int>? items,
    bool? hasReachedMax,
  }) {
    return _ItemsState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ItemsState &&
        listEquals(other.items, items) &&
        other.hasReachedMax == hasReachedMax;
  }

  @override
  int get hashCode => items.hashCode ^ hasReachedMax.hashCode;
}
