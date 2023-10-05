// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

part 'opacity_range.dart';
part 'flexible_space_options.dart';

/// {@template re_seedwork.widgets.persistentAppBar}
/// Custom app bar with cupertino-like behavior.
/// {@endtemplate}
///
/// When [largeTitle] is visible, [title] is hidden, and vice versa.
class PersistentAppBar extends SliverPersistentHeaderDelegate {
  /// Creates a
  /// {@macro re_seedwork.widgets.persistentAppBar}
  const PersistentAppBar({
    this.topSafeArea = 0,
    this.title,
    this.leading,
    this.largeTitle,
    this.appBarCollapsedColor,
    this.largeTitlePadding = EdgeInsets.zero,
    this.largeTitleHeight = 40,
    this.flexibleSpace,
    this.toolbarHeight = kToolbarHeight,
    this.flexibleOpacityRange = const OpacityRange.factor(start: .4, end: 1),
    this.appBarTitleOpacityRange =
        const OpacityRange.offset(start: 70, end: 40),
    this.appBarBackgroundOpacityRange = const OpacityRange.offset(
      start: 90,
      end: 70,
    ),
    this.appBarTitleTextStyle,
    this.largeTitleTextStyle,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.flexibleSpaceOptions = const FlexibleSpaceOptions(),
  });

  /// Optional widget, which will be placed under app bar
  @protected
  final Widget? flexibleSpace;

  /// Height of the safe area on top of the screen to avoid drops, notches, etc.
  /// with device interfaces(like camera, scanners, etc.)
  ///
  /// Defults to `0`
  @protected
  final double topSafeArea;

  /// {@macro re_seedwork.widgets.persistentAppBar.flexibleSpaceOptions}
  @protected
  final FlexibleSpaceOptions flexibleSpaceOptions;

  /// Toolbar height.
  ///
  /// Defaults to [kToolbarHeight]
  @protected
  final double toolbarHeight;

  /// Optional title, which will be placed below app bar
  /// and [flexibleSpace] widget(if specified)
  @protected
  final String? largeTitle;

  /// Optional title, which will be passed to [AppBar.title] as [Text] widget.
  @protected
  final String? title;

  /// Padding for [largeTitle].
  ///
  /// Defaults to [EdgeInsets.zero]
  @protected
  final EdgeInsets largeTitlePadding;

  /// Height of [largeTitle]
  ///
  /// Defaiults to `40`
  @protected
  final double largeTitleHeight;

  /// The [OpacityRange] for app bar title([title])
  @protected
  final OpacityRange appBarTitleOpacityRange;

  /// The [OpacityRange] for app bar's background color([appBarCollapsedColor])
  @protected
  final OpacityRange appBarBackgroundOpacityRange;

  /// The [OpacityRange] for [flexibleSpace]
  @protected
  final OpacityRange flexibleOpacityRange;

  /// AppBar color when app bar is collapsed.
  ///
  /// Defaults to [Theme.of(context).appBarTheme.backgroundColor]
  @protected
  final Color? appBarCollapsedColor;

  /// [TextStyle] for app bar's title([title])
  ///
  /// Defaults to [Theme.of(context).appBarTheme.titleTextStyle]
  @protected
  final TextStyle? appBarTitleTextStyle;

  /// [TextStyle] for [largeTitle]
  ///
  /// Defaults to [Theme.of(context).textTheme.headline5]
  @protected
  final TextStyle? largeTitleTextStyle;

  /// {@macro flutter.material.appbar.actions}
  @protected
  final List<Widget>? actions;

  /// {@macro flutter.material.appbar.automaticallyImplyLeading}
  @protected
  final bool automaticallyImplyLeading;

  /// {@macro flutter.material.appbar.leading}
  @protected
  final Widget? leading;

  /// Calculates the object opacity using [opacityRange] and
  /// current [offset] or [expandFactor] (depends on [opacityRange] type)
  @visibleForTesting
  double calculateOpacity({
    required OpacityRange opacityRange,
    required double expandFactor,
    required double offset,
  }) {
    if (opacityRange.isEqual) {
      return opacityRange.start +
          (opacityRange.inclusiveSafeArea ? 0 : topSafeArea);
    }

    final value = opacityRange.when(
      offset: () {
        return (offset - (opacityRange.inclusiveSafeArea ? 0 : topSafeArea))
            .clamp(0, double.infinity);
      },
      factor: () {
        final topSafeAreaFactor = topSafeArea / maxExtent;
        return (expandFactor -
                (opacityRange.inclusiveSafeArea ? 0 : topSafeAreaFactor))
            .clamp(0, 1);
      },
    );

    if (opacityRange.isIncreasing) {
      if (value < opacityRange.start) return 0;
      if (value > opacityRange.end) return 1;
      return (value - opacityRange.start) / opacityRange.difference;
    }

    if (value < opacityRange.end) return 1;
    if (value > opacityRange.start) return 0;
    return (opacityRange.difference - (value - opacityRange.end)) /
        opacityRange.difference;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final flexible = flexibleSpace;
    final _largeTitle = largeTitle;
    final _title = _largeTitle ?? title;
    final expandFactor = 1 - shrinkOffset / maxExtent;
    final offset = maxExtent - shrinkOffset;

    final appBarTitleOpacity = calculateOpacity(
      opacityRange: appBarTitleOpacityRange,
      expandFactor: expandFactor,
      offset: offset,
    );

    final appBarBackgroundColorOpacity = calculateOpacity(
      opacityRange: appBarBackgroundOpacityRange,
      expandFactor: expandFactor,
      offset: offset,
    );

    final flexibleOpacity = calculateOpacity(
      opacityRange: flexibleOpacityRange,
      expandFactor: expandFactor,
      offset: offset,
    );

    return Stack(
      children: [
        if (flexible != null || _largeTitle != null)
          Positioned.fill(
            top: null,
            child: SizedBox(
              height: largeTitleHeight + flexibleSpaceOptions.height,
              child: Column(
                children: [
                  if (flexible != null)
                    Expanded(
                      child: Opacity(
                        opacity: flexibleOpacity,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: double.infinity,
                            child: flexible,
                          ),
                        ),
                      ),
                    )
                  else
                    const Spacer(),
                  if (_largeTitle != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: largeTitlePadding,
                        child: Text(
                          _largeTitle,
                          style: largeTitleTextStyle ??
                              Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: AppBar(
            toolbarHeight: toolbarHeight,
            automaticallyImplyLeading: automaticallyImplyLeading,
            leading: leading,
            title: _title == null
                ? null
                : Opacity(
                    opacity: appBarTitleOpacity,
                    child: Text(
                      _title,
                      style: appBarTitleTextStyle,
                    ),
                  ),
            backgroundColor: (appBarCollapsedColor ??
                    Theme.of(context).appBarTheme.backgroundColor)
                ?.withOpacity(appBarBackgroundColorOpacity),
            shadowColor: Colors.transparent,
            actions: actions,
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent {
    return flexibleSpaceOptions.height +
        largeTitleHeight +
        flexibleSpaceOptions.mode.when(
          useSafeAreaAndToolbar: () => 0,
          useToolbar: () => topSafeArea,
          none: () => toolbarHeight + topSafeArea,
        );
  }

  @override
  double get minExtent => toolbarHeight + topSafeArea;

  @override
  bool shouldRebuild(covariant PersistentAppBar oldDelegate) {
    return oldDelegate.title != title ||
        oldDelegate.largeTitle != largeTitle ||
        oldDelegate.appBarCollapsedColor != appBarCollapsedColor ||
        oldDelegate.largeTitlePadding != largeTitlePadding ||
        oldDelegate.largeTitleHeight != largeTitleHeight ||
        oldDelegate.flexibleSpace != flexibleSpace ||
        oldDelegate.flexibleSpaceOptions != flexibleSpaceOptions ||
        oldDelegate.toolbarHeight != toolbarHeight ||
        oldDelegate.flexibleOpacityRange != flexibleOpacityRange ||
        oldDelegate.appBarTitleOpacityRange != appBarTitleOpacityRange ||
        oldDelegate.appBarBackgroundOpacityRange !=
            appBarBackgroundOpacityRange ||
        oldDelegate.appBarTitleTextStyle != appBarTitleTextStyle ||
        oldDelegate.largeTitleTextStyle != largeTitleTextStyle ||
        oldDelegate.actions != actions ||
        oldDelegate.automaticallyImplyLeading != automaticallyImplyLeading;
  }
}
