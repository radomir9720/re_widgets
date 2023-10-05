import 'package:flutter/widgets.dart';

/// {@template re_seedwork.widgets.dotsPageIndicator}
/// Paints dots to indicate which page is active, and how many pages are there.
///
/// Meant to be used with [PageView]
/// {@endtemplate}
class DotsPageIndicator extends StatelessWidget {
  /// Creates
  /// {@macro re_seedwork.widgets.dotsPageIndicator}
  const DotsPageIndicator({
    super.key,
    required this.pageController,
    required this.count,
    this.dotSize = const Size.square(7),
    this.inactiveDotDecoration = kInactiveDotDecoration,
    this.activeDotDecoration = kActiveDotDecoration,
    this.gap = 4,
  });

  /// [PageController] which also should be passed to a [PageView]
  @protected
  final PageController pageController;

  /// Number of pages(dots)
  @protected
  final int count;

  /// The size of dot
  @protected
  final Size dotSize;

  /// Gap between dots
  @protected
  final double gap;

  /// [Decoration] for inactive dot([PageController().page] points to
  /// another page)
  @protected
  final Decoration inactiveDotDecoration;

  /// [Decoration] for active dot([PageController().page] points to
  /// this page)
  @protected
  final Decoration activeDotDecoration;

  /// The default decoration for inactive dot
  @protected
  static const kInactiveDotDecoration = ShapeDecoration(
    shape: CircleBorder(),
    color: Color(0xFFC8C8C9),
  );

  /// The default decoration for active dot
  @protected
  static const kActiveDotDecoration = ShapeDecoration(
    shape: CircleBorder(),
    color: Color(0xFF6D7278),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(
            count * 2 - 1,
            (index) {
              if (index.isOdd) return SizedBox(width: gap);

              return SizedBox.fromSize(
                size: dotSize,
                child: DecoratedBox(
                  decoration: inactiveDotDecoration,
                ),
              );
            },
          ),
        ),
        ListenableBuilder(
          listenable: pageController,
          builder: (BuildContext context, Widget? child) {
            return Positioned(
              left: (pageController.page ?? 0) * (dotSize.width + gap),
              child: child ?? const SizedBox.shrink(),
            );
          },
          child: SizedBox.fromSize(
            size: dotSize,
            child: DecoratedBox(
              decoration: activeDotDecoration,
            ),
          ),
        ),
      ],
    );
  }
}
