part of 'fade_shader.dart';

/// Value notifier, which sends new [FadeSideFactorState] when it changes
class FadeSideFactorChangeNotifier extends ValueNotifier<FadeSideFactorState> {
  /// Creates a new instance of [FadeSideFactorChangeNotifier]
  FadeSideFactorChangeNotifier(super.value);

  /// Should be called when need to change fade factor effect of the start/end.
  ///
  /// It will send new [FadeSideFactorState] to listeners
  /// (if the new state differs from the old one).
  void updateFadeFactor({
    double? start,
    double? end,
  }) {
    value = value.copyWith(start: start, end: end);
  }
}

/// State, which contains the start and end fade factors of a widget
@immutable
class FadeSideFactorState {
  /// Creates a new instance of [FadeSideFactorState]
  const FadeSideFactorState({
    required this.start,
    required this.end,
  });

  ///  Start fade factor of widget
  final double start;

  /// End fade factor of widget
  final double end;

  /// Creates and returns a new instance of [FadeSideFactorState] from current,
  /// and replaces the current parameters with the passed ones
  /// if they are not null.
  FadeSideFactorState copyWith({
    double? start,
    double? end,
  }) {
    return FadeSideFactorState(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FadeSideFactorState &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}
