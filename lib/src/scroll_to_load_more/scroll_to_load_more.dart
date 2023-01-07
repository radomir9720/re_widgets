import 'package:flutter/widgets.dart';

part 'scroll_to_load_more_state.dart';

/// {@template re_seedwork.widgets.scrollToLoadMore}
/// Widget, which helps to load data batches(add more items to scrollable view)
/// {@endtemplate}
class ScrollToLoadMore extends StatelessWidget {
  /// Creates a
  /// {@macro re_seedwork.widgets.scrollToLoadMore}
  const ScrollToLoadMore({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.cancelDispatching = true,
    this.triggerThreshold = .8,
    required this.scrollableBuilder,
    required this.onTriggered,
    required this.hasReachedMax,
    required this.loadingIndicator,
    required this.failureWidget,
    required this.state,
    this.hasReachedMaxWidget,
  }) : assert(
          triggerThreshold <= 1 && triggerThreshold >= 0,
          'Should be between 0 and 1',
        );

  /// The scroll direction
  ///
  /// Defaults to [Axis.vertical]
  @protected
  final Axis scrollDirection;

  /// Builder function, that should return a scrollable widget.
  ///
  /// [scrollableBuilder] provides `bottom` widget, which can be just
  /// an empty placeholder([SizedBox.shrink()]), [loadingIndicator],
  /// or [failureWidget], depending on the [state].
  @protected
  final Widget Function(Widget bottom) scrollableBuilder;

  /// Whether should continue or cancel notifications dispatching
  /// for further ancestors.
  ///
  /// Return `true` to cancel the notification bubbling. Return `false` to
  /// allow the notification to continue to be dispatched to further ancestors.
  ///
  /// Defaults to `true`
  ///
  /// For more information on this parameter open
  /// [NotificationListener.onNotification] docstring
  @protected
  final bool cancelDispatching;

  /// How much(which part of the screen) should the user scroll through for
  /// [onTriggered] to be called. Should be between 0 and 1.
  ///
  /// For example, [triggerThreshold] = .5 means that [onTriggered] will be
  /// called when the user will scroll half of the viewport(screen).
  @protected
  final double triggerThreshold;

  /// Callback, that will be called when the offset of the scrollable area
  /// reaches [triggerThreshold]
  @protected
  final VoidCallback onTriggered;

  /// {@macro re_seedwork.widgets.scrollToLoadMore.state}
  @protected
  final ScrollToLoadMoreState state;

  /// No items to load. [onTriggered] will NOT be called anymore.
  @protected
  final bool hasReachedMax;

  /// Widget to be displayed at the bottom(as last item) when [state]
  /// is [ScrollToLoadMoreState.loading]
  @protected
  final Widget loadingIndicator;

  /// Widget to be displayed at the bottom(as last item) when [state]
  /// is [ScrollToLoadMoreState.failure]
  @protected
  final Widget failureWidget;

  /// Widget to be displayed at the bottom(as last item) when there are no items
  /// to load([hasReachedMax] == `true`).
  /// If `null`, then nothing will be displayed.
  @protected
  final Widget? hasReachedMaxWidget;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.axis != scrollDirection) return false;

        if (hasReachedMax) return cancelDispatching;
        if (state.isLoading) return cancelDispatching;
        if (state.isFailure) return cancelDispatching;

        final viewport = notification.metrics.viewportDimension;
        final maxExtent = notification.metrics.maxScrollExtent;
        final triggerOffset = maxExtent - (viewport * (1 - triggerThreshold));
        final currExtent = notification.metrics.pixels;

        if (currExtent >= triggerOffset) onTriggered();

        return cancelDispatching;
      },
      child: scrollableBuilder(
        state.maybeWhen(
          orElse: () {
            if (hasReachedMax) {
              return hasReachedMaxWidget ?? const SizedBox.shrink();
            }

            return const SizedBox.shrink();
          },
          loading: () => loadingIndicator,
          failure: () => failureWidget,
        ),
      ),
    );
  }
}
