part of 'persistent_app_bar.dart';

/// Base class which
/// {@template re_seedwork.widgets.persistentAppBar.opacityRange}
/// contains info about the opacity range
/// (where should start to add transparency to the object,
/// where is the end of the range,
/// and whether the `start` and `end` parameters include safe area or not)
/// {@endtemplate}
@immutable
abstract class OpacityRange {
  /// Creates a object, that
  /// {@macro re_seedwork.widgets.persistentAppBar.opacityRange}
  const OpacityRange({
    required this.start,
    required this.end,
    required this.inclusiveSafeArea,
  });

  /// {@macro re_seedwork.widgets.persistentAppBar.offsetOpacityRange}
  const factory OpacityRange.offset({
    required double start,
    required double end,
    bool inclusiveSafeArea,
  }) = OffsetOpacityRange;

  /// {@macro re_seedwork.widgets.persistentAppBar.factorOpacityRange}
  const factory OpacityRange.factor({
    required double start,
    required double end,
    bool inclusiveSafeArea,
  }) = FactorOpacityRange;

  /// Start of the opacity range.
  final double start;

  /// End of the opacity range.
  final double end;

  /// Whether specified `start` and `end` parameters already include
  /// the top safe area, or the top safe area should be additionally added
  final bool inclusiveSafeArea;

  /// Returns `true` when `start` and `end` are equal. Otherwise - `false`
  bool get isEqual => end == start;

  /// Returns `true` when `end` is greater than `start`. Otherwise - `false`
  bool get isIncreasing => end > start;

  /// Returns `true` when end is less than `start`. Otherwise - `false`
  bool get isDecreasing => end < start;

  /// Returns the absolute value of the difference between `end` and `start`.
  /// (range length)
  double get difference => (end - start).abs();

  /// Pattern matching function by type. Executes the corresponding to the type
  /// callback, and returns the result of it
  R when<R>({
    required R Function() offset,
    required R Function() factor,
  });
}

/// {@template re_seedwork.widgets.persistentAppBar.offsetOpacityRange}
/// Scroll offset implementation of the base class [OpacityRange]
/// (scroll offset determines the opacity range),
/// {@endtemplate}
/// {@macro re_seedwork.widgets.persistentAppBar.opacityRange}
@immutable
class OffsetOpacityRange extends OpacityRange {
  /// Creates [OffsetOpacityRange]
  ///
  /// [inclusiveSafeArea] defaults to `false`
  const OffsetOpacityRange({
    required super.start,
    required super.end,
    super.inclusiveSafeArea = false,
  });

  @override
  R when<R>({required R Function() offset, required R Function() factor}) {
    return offset();
  }
}

/// {@template re_seedwork.widgets.persistentAppBar.factorOpacityRange}
/// Scroll factor implementation of the base class [OpacityRange]
/// (ratio of max scroll extent to current offset determines the opacity range),
/// {@endtemplate}
/// {@macro re_seedwork.widgets.persistentAppBar.opacityRange}
@immutable
class FactorOpacityRange extends OpacityRange {
  /// Creates [FactorOpacityRange]
  ///
  /// `start` and `end` parameters both should be in the range
  /// between `0` and `1`
  ///
  /// [inclusiveSafeArea] defaults to `false`
  const FactorOpacityRange({
    required super.start,
    required super.end,
    super.inclusiveSafeArea = false,
  })  : assert(
          start >= 0 && start <= 1,
          'FractionalOpacityRange.start should be '
          'greater than or equal to 0 '
          'and '
          'less than or equal to 1',
        ),
        assert(
          end >= 0 && end <= 1,
          'FractionalOpacityRange.end should be '
          'greater than or equal to 0 '
          'and '
          'less than or equal to 1',
        );

  @override
  R when<R>({required R Function() offset, required R Function() factor}) {
    return factor();
  }
}
