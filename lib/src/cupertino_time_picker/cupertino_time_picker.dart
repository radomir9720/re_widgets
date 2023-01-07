import 'package:flutter/cupertino.dart';

part 'extended_date_time.dart';

/// {@template re_seedwork.widgets.cupertinoHourMinutePicker}
/// Two cupertino pickers. First one is for hour, second one is for minute.
/// {@endtemplate}
class CupertinoHourMinutePicker extends StatefulWidget {
  /// Creates
  /// {@macro re_seedwork.widgets.cupertinoHourMinutePicker}
  const CupertinoHourMinutePicker({
    super.key,
    this.initialTime,
    this.backgroundColor,
    this.squeeze = kSqueeze,
    this.width = kPickerWidth,
    this.height = kPickerHeight,
    this.useMagnifier = true,
    this.hoursLooping = false,
    this.minutesLooping = false,
    this.itemExtent = kItemExtent,
    this.maxTime,
    this.minTime,
    this.diameterRatio = kDiameterRatio,
    this.magnification = kMagnification,
    this.paddingBetween = kPaddingBetween,
    this.onChanged,
    this.customOffAxisFraction,
  })  : assert(
          initialTime == null || minTime == null || initialTime >= minTime,
          '"initialTime" must be greater than or equal to "minTime" '
          'if both "intitalTime" and "minTime" are specified',
        ),
        assert(
          initialTime == null || maxTime == null || initialTime <= maxTime,
          '"initialTime" must be less than or equal to "maxTime" if both '
          '"intitalTime" and "maxTime" are specified',
        );

  /// Total height of the widget. Defaults to [kPickerHeight]
  @protected
  final double height;

  /// Total width of the widget. Defaults to [kPickerWidth]
  @protected
  final double width;

  /// Item extent. Defaults to [kItemExtent]
  @protected
  final double itemExtent;

  /// {@macro flutter.rendering.RenderListWheelViewport.useMagnifier}
  @protected
  final bool useMagnifier;

  /// The zoomed-in rate of the magnifier, if it is used.
  /// Defaults to [kMagnification]
  ///
  /// If the value is 1.0, this will not change anything.
  /// If the value is > 1.0, the center item will be zoomed in by that rate,
  /// and it will also be rendered as flat, not cylindrical like the rest of
  /// the list. The item will be zoomed out if magnification < 1.0.
  ///
  /// Must be positive.
  @protected
  final double magnification;

  /// {@macro flutter.rendering.RenderListWheelViewport.squeeze}
  ///
  /// Defaults to [kSqueeze].
  @protected
  final double squeeze;

  /// {@template re_seedwork.widgets.cupertinoHourMinutePicker.looping}
  /// Decides whether the child list loops and can be
  /// scrolled infinitely.  If set to true, scrolling past the end of the list
  /// will loop the list back to the beginning.  If set to false, the list will
  /// stop scrolling when you reach the end or the beginning.
  /// {@endtemplate}
  ///
  /// Defaults to `false`
  @protected
  final bool hoursLooping;

  /// {@macro re_seedwork.widgets.cupertinoHourMinutePicker.looping}
  ///
  /// Defaults to `false`
  @protected
  final bool minutesLooping;

  /// How much the wheel is horizontally off-center, as a fraction of its width.
  /// This property creates the visual effect of looking at a vertical wheel
  /// from its side where its vanishing points at the edge curves to one side
  /// instead of looking at the wheel head-on.
  ///
  /// The value is horizontal distance between the wheel's center and the
  /// vertical vanishing line at the edges of the wheel,
  /// represented as a fraction of the wheel's width.
  ///
  /// The value 0.0 means the wheel is looked at head-on and its vanishing line
  /// runs through the center of the wheel. Negative values means moving the
  /// wheel to the left of the observer, thus the edges curve to the right.
  /// Positive values means moving the wheel to the right of the observer,
  /// thus the edges curve to the left.
  ///
  /// The visual effect causes the wheel's edges to curve rather than moving
  /// the center. So a value of 0.5 means the edges' vanishing line will touch
  /// the wheel's size's left edge.
  ///
  /// By default the `offAxisFraction` is calculated automatically by the getter
  ///  [_CupertinoHourMinutePickerState().calculateOffAxisFraction]
  @protected
  final double? customOffAxisFraction;

  /// Padding between hour and minute pickers.
  ///
  /// Defaults to [kPaddingBetween]
  @protected
  final double paddingBetween;

  /// By default - [ExtDateTime.todaysStart()]
  @protected
  final ExtendedDateTime? minTime;

  /// By default - [ExtDateTime.todaysEnd()]
  @protected
  final ExtendedDateTime? maxTime;

  /// The initial time
  @protected
  final ExtendedDateTime? initialTime;

  /// Background color behind the picker values(hours/minutes).
  ///
  /// Defaults to null, which disables background painting entirely.
  /// (i.e. the picker is going to have a completely transparent background),
  /// to match the native UIPicker and UIDatePicker.
  ///
  /// Any alpha value less 255 (fully opaque) will cause the removal of the
  /// wheel list edge fade gradient from rendering of the widget.
  @protected
  final Color? backgroundColor;

  /// Relative ratio between this picker's height and the
  /// simulated cylinder's diameter.
  ///
  /// Smaller values creates more pronounced curvatures in the scrollable wheel.
  ///
  /// For more details, see [ListWheelScrollView.diameterRatio].
  ///
  /// Defaults to [kDiameterRatio]
  @protected
  final double diameterRatio;

  /// An option callback when the currently centered item changes.
  ///
  /// Value changes when the item closest to the center changes.
  ///
  /// This can be called during scrolls and during ballistic flings. To get the
  /// value only when the scrolling settles, use a [NotificationListener],
  /// listen for [ScrollEndNotification] and read its [FixedExtentMetrics].
  @protected
  final ValueSetter<ExtendedDateTime>? onChanged;

  /// Default picker's height
  @protected
  static const kPickerHeight = 216.0;

  /// Default picker's width
  @protected
  static const kPickerWidth = 320.0;

  /// Default magnification
  @protected
  static const kMagnification = 1.119;

  /// Default item extent
  @protected
  static const kItemExtent = 32.0;

  /// Default squeeze
  @protected
  static const kSqueeze = 1.25;

  /// Default padding between pickers
  @protected
  static const kPaddingBetween = 30.0;

  /// Default diameter ratio
  @protected
  static const kDiameterRatio = 1.07;

  @override
  State<CupertinoHourMinutePicker> createState() =>
      _CupertinoHourMinutePickerState();
}

class _CupertinoHourMinutePickerState extends State<CupertinoHourMinutePicker> {
  late final FixedExtentScrollController hoursController;
  late final FixedExtentScrollController minutesController;
  late final ValueNotifier<List<int>> minutesAvailableRangeNotifier;
  late ExtendedDateTime value;
  late int minutesIndex;

  ExtendedDateTime get minTime =>
      widget.minTime ?? ExtendedDateTime.todaysStart();
  ExtendedDateTime get maxTime =>
      widget.maxTime ?? ExtendedDateTime.todaysEnd();

  @override
  void initState() {
    super.initState();

    value = widget.initialTime ?? minTime;

    assert(
      value >= minTime && value <= maxTime,
      'If "initialTime" is '
      'specified, ensure it\'s greater than or equal to "minTime" '
      'and less than or equal to "maxTime"',
    );

    minutesIndex = value.minute - minTime.minute;

    minutesAvailableRangeNotifier = ValueNotifier(
      getAvailableMinutesRange(
        currentDateTime: value,
        updateMinutes: false,
      ),
    );

    hoursController = FixedExtentScrollController(
      initialItem: value.hour - minTime.hour,
    );

    minutesController = FixedExtentScrollController(
      initialItem: value.minute - minTime.minute,
    );
  }

  @visibleForTesting
  double get calculateOffAxisFraction {
    final widthForOneHalf = widget.width / 2;
    final paddingForOneHalf = widget.paddingBetween / 2;
    return .5 - paddingForOneHalf / widthForOneHalf;
  }

  @visibleForTesting
  TextStyle textStyleFrom(BuildContext context, [double magnification = 1.0]) {
    final textStyle = CupertinoTheme.of(context).textTheme.pickerTextStyle;
    return textStyle.copyWith(
      color: CupertinoDynamicColor.maybeResolve(textStyle.color, context),
      fontSize: textStyle.fontSize! * magnification,
    );
  }

  List<int> getAvailableMinutesRange({
    required ExtendedDateTime currentDateTime,
    bool updateMinutes = true,
  }) {
    final minHour = minTime.truncate(ExtendedDateTimeTruncateType.minute);
    final maxHour = maxTime.truncate(ExtendedDateTimeTruncateType.minute);
    final currentTruncated = currentDateTime.truncate(
      ExtendedDateTimeTruncateType.minute,
    );
    final minMinute = minTime.minute;
    final maxMinute = maxTime.minute;

    var list = List.generate(60, (index) => index);

    if (currentTruncated <= minHour) {
      list = List.generate(60 - minMinute, (index) {
        return index + minMinute;
      });
    } else if (currentTruncated >= maxHour) {
      list = List.generate(maxMinute, (index) => index);
    }

    if (updateMinutes) updateMinutesIfNeed(list);
    return list;
  }

  void updateMinutesIfNeed(List<int> minutesRange) {
    final currentMinute = minutesRange[minutesIndex];
    if (currentMinute == value.minute) return;
    value = value.copyWith(minute: currentMinute);
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final offAxisFraction =
        widget.customOffAxisFraction ?? calculateOffAxisFraction;
    final hoursCount = maxTime.difference(minTime).inHours;

    return DefaultTextStyle(
      style: textStyleFrom(context, widget.magnification),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Row(
          children: [
            Expanded(
              child: CupertinoPicker(
                squeeze: widget.squeeze,
                looping: widget.hoursLooping,
                itemExtent: widget.itemExtent,
                offAxisFraction: -offAxisFraction,
                useMagnifier: widget.useMagnifier,
                magnification: widget.magnification,
                diameterRatio: widget.diameterRatio,
                backgroundColor: widget.backgroundColor,
                onSelectedItemChanged: (index) {
                  final currentDateTime = minTime.add(Duration(hours: index));
                  value = value.copyWith(
                    day: currentDateTime.day,
                    hour: currentDateTime.hour,
                  );
                  minutesAvailableRangeNotifier.value =
                      getAvailableMinutesRange(
                    currentDateTime: value,
                  );
                  widget.onChanged?.call(value);
                },
                scrollController: hoursController,
                selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                  capEndEdge: false,
                ),
                children: List<Widget>.generate(hoursCount + 1, (int index) {
                  return Container(
                    padding: EdgeInsets.only(right: widget.paddingBetween / 2),
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${minTime.add(Duration(hours: index)).hour}',
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<List<int>>(
                valueListenable: minutesAvailableRangeNotifier,
                builder: (context, availableRange, child) {
                  return CupertinoPicker(
                    squeeze: widget.squeeze,
                    itemExtent: widget.itemExtent,
                    looping: widget.minutesLooping,
                    offAxisFraction: offAxisFraction,
                    useMagnifier: widget.useMagnifier,
                    magnification: widget.magnification,
                    scrollController: minutesController,
                    diameterRatio: widget.diameterRatio,
                    backgroundColor: widget.backgroundColor,
                    onSelectedItemChanged: (index) {
                      minutesIndex = index;
                      updateMinutesIfNeed(availableRange);
                    },
                    selectionOverlay:
                        const CupertinoPickerDefaultSelectionOverlay(
                      capStartEdge: false,
                    ),
                    children: List<Widget>.generate(availableRange.length,
                        (int index) {
                      return Container(
                        padding:
                            EdgeInsets.only(left: widget.paddingBetween / 2),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${availableRange[index]}',
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
