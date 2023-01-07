part of 'fade_shader.dart';

/// Value notifier, which sends new [EnableFadeSideState] when it changes
class EnableFadeSideChangeNotifier extends ValueNotifier<EnableFadeSideState> {
  /// Creates a new instance of [EnableFadeSideChangeNotifier]
  EnableFadeSideChangeNotifier(super.value);

  /// Should be called when need to enable/disable fade effect of the start/end.
  ///
  /// It will send new [EnableFadeSideState] to listeners.
  void update({
    bool? enableStart,
    bool? enableEnd,
  }) {
    value = value.copyWith(enableStart: enableStart, enableEnd: enableEnd);
  }
}

/// State, which contains the data wheter should the start and/or end of a widget
/// be faded.
@immutable
class EnableFadeSideState {
  /// Creates a new instance of [EnableFadeSideState]
  const EnableFadeSideState({
    required this.enableStart,
    required this.enableEnd,
  });

  /// Wheter should be faded the start of widget
  final bool enableStart;

  /// Wheter should be faded the end of widget
  final bool enableEnd;

  /// Returns `true` if both [enableStart] and [enableEnd] are `false`
  /// (should NOT be faded).
  bool get bothDisabled => !enableStart && !enableEnd;

  /// Creates and returns a new instance of [EnableFadeSideState] from current,
  /// and replaces the current parameters with the passed ones
  /// if they are not null.
  EnableFadeSideState copyWith({
    bool? enableStart,
    bool? enableEnd,
  }) {
    return EnableFadeSideState(
      enableStart: enableStart ?? this.enableStart,
      enableEnd: enableEnd ?? this.enableEnd,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnableFadeSideState &&
        other.enableStart == enableStart &&
        other.enableEnd == enableEnd;
  }

  @override
  int get hashCode => enableStart.hashCode ^ enableEnd.hashCode;
}
