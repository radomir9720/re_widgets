import 'package:flutter/material.dart';
import 'package:re_seedwork/re_seedwork.dart';

/// {@template re_seedwork.widgets.loadMoreIndicator}
/// A progress indicator in the form of several dots (default 3) of
/// a certain color, which animately change their transparency.
/// {@endtemplate}
class LoadMoreIndicator extends StatefulWidget {
  /// Creates
  /// {@macro re_seedwork.widgets.loadMoreIndicator}
  const LoadMoreIndicator({
    super.key,
    this.color,
    this.dotsNumber = 3,
    this.duration = const Duration(milliseconds: 500),
    this.dotSize = 10,
    this.paddingBetweenDots = 5,
  });

  /// The number of dots.
  ///
  /// Dafults to `3`
  @protected
  final int dotsNumber;

  /// Duration of one animation cycle
  ///
  /// Defaults to `500` millis
  @protected
  final Duration duration;

  /// Size of a dot(its width and height)
  ///
  /// Defaults to `10`
  @protected
  final double dotSize;

  /// Padding between dots
  ///
  /// Defaults to `5`
  @protected
  final double paddingBetweenDots;

  /// Optional. Dots color.
  ///
  /// Defaults to [Theme.of(context).primaryColor]
  @protected
  final Color? color;

  @override
  State<LoadMoreIndicator> createState() => _LoadMoreIndicatorState();
}

class _LoadMoreIndicatorState extends State<LoadMoreIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller
      ..stop()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final segmentLength = 1 / (widget.dotsNumber - 1);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List<Widget>.generate(
                widget.dotsNumber,
                (index) {
                  final segmentCenter = segmentLength * index;
                  final opacity = 1 - (controller.value - segmentCenter).abs();

                  return Container(
                    height: widget.dotSize,
                    width: widget.dotSize,
                    decoration: ShapeDecoration(
                      shape: const CircleBorder(),
                      color: widget.color ??
                          Theme.of(context).primaryColor.withOpacity(opacity),
                    ),
                  );
                },
              ).divideBy(SizedBox(width: widget.paddingBetweenDots)).toList(),
            );
          },
        ),
      ),
    );
  }
}
