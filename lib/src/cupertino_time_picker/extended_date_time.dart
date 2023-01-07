part of 'cupertino_time_picker.dart';

/// {@template re_seedwork.widgets.extendedDateTime}
/// Class, that extends [DateTime] and ads a couple of useful functions
/// and constructors
/// {@endtemplate}
class ExtendedDateTime extends DateTime {
  /// Creates a
  /// {@macro re_seedwork.widgets.extendedDateTime}
  ExtendedDateTime(
    super.year, [
    super.month,
    super.day,
    super.hour,
    super.minute,
  ]);

  /// Creates and returns an instance of [ExtendedDateTime], year, month, day,
  /// hour and minute of which equals to the today's last minute.
  factory ExtendedDateTime.todaysEnd() {
    final now = DateTime.now();
    return ExtendedDateTime(now.year, now.month, now.day, 23, 59);
  }

  /// Creates and returns an instance of [ExtendedDateTime], year, month, day,
  /// hour and minute of which equals to the today's zero hour and zero second.
  factory ExtendedDateTime.todaysStart() {
    final now = DateTime.now();
    return ExtendedDateTime(now.year, now.month, now.day);
  }

  /// Creates and returns an instance of [ExtendedDateTime] from [DateTime]
  factory ExtendedDateTime.fromDateTime(DateTime dateTime) {
    return ExtendedDateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
    );
  }

  /// Truncates(removes/resets/sets equal to 0)
  /// a certain time unit(day, hour, or minute)
  ExtendedDateTime truncate(ExtendedDateTimeTruncateType truncateType) {
    return truncateType.when(
      day: () => ExtendedDateTime(year, month),
      hour: () => ExtendedDateTime(year, month, day),
      minute: () => ExtendedDateTime(year, month, day, hour),
    );
  }

  /// Determines whether the current dateTime is
  /// less than
  /// passed [other] dateTime
  bool operator <(ExtendedDateTime other) =>
      microsecondsSinceEpoch < other.microsecondsSinceEpoch;

  /// Determines whether the current dateTime is
  /// greater than
  /// passed [other] dateTime
  bool operator >(ExtendedDateTime other) =>
      microsecondsSinceEpoch > other.microsecondsSinceEpoch;

  /// Determines whether the current dateTime is
  /// less than or equal to
  /// passed [other] dateTime
  bool operator <=(ExtendedDateTime other) =>
      microsecondsSinceEpoch <= other.microsecondsSinceEpoch;

  /// Determines whether the current dateTime is
  /// greater than or equal to
  /// passed [other] dateTime
  bool operator >=(ExtendedDateTime other) =>
      microsecondsSinceEpoch >= other.microsecondsSinceEpoch;

  @override
  ExtendedDateTime add(Duration duration) {
    return ExtendedDateTime.fromDateTime(super.add(duration));
  }

  @override
  ExtendedDateTime subtract(Duration duration) {
    return ExtendedDateTime.fromDateTime(super.subtract(duration));
  }

  /// Creates and returns a new instance of [ExtendedDateTime] from current,
  /// and replaces current time units(year, month, day, etc.) with passed ones
  /// if they are not null.
  ExtendedDateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
  }) {
    return ExtendedDateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
    );
  }
}

/// Enum, which specifies [ExtendedDateTime] truncate types.
enum ExtendedDateTimeTruncateType {
  /// Truncate by day
  day,

  /// Truncate by hour
  hour,

  /// Truncate by minute
  minute;

  /// Pattern matching function by type. Executes the corresponding to the type
  /// callback, and returns the result of it
  R when<R>({
    required R Function() day,
    required R Function() hour,
    required R Function() minute,
  }) {
    switch (this) {
      case ExtendedDateTimeTruncateType.day:
        return day();
      case ExtendedDateTimeTruncateType.hour:
        return hour();
      case ExtendedDateTimeTruncateType.minute:
        return minute();
    }
  }
}
