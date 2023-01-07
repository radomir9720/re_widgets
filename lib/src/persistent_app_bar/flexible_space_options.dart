part of 'persistent_app_bar.dart';

/// {@template re_seedwork.widgets.persistentAppBar.flexibleSpaceOptions}
/// Options for `flexibleSpace` widget
/// {@endtemplate}
@immutable
class FlexibleSpaceOptions {
  /// Creates
  /// {@macro re_seedwork.widgets.persistentAppBar.flexibleSpaceOptions}
  const FlexibleSpaceOptions({
    this.height = 200,
    this.mode = FlexibleSpaceMode.useToolbar,
  });

  /// `flexibleSpace` widget's height
  final double height;

  /// {@macro re_seedwork.widgets.persistentAppBar.flexibleSpaceOptions.mode}
  final FlexibleSpaceMode mode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlexibleSpaceOptions &&
        other.height == height &&
        other.mode == mode;
  }

  @override
  int get hashCode => height.hashCode ^ mode.hashCode;
}

/// {@template re_seedwork.widgets.persistentAppBar.flexibleSpaceOptions.mode}
/// Enum, which contains the info about whether should the
/// `flexibleSpace` widget occupy the top safe area and the toolbar or not
/// {@endtemplate}
enum FlexibleSpaceMode {
  /// `flexibleSpace` should occupy both safe area and toolbar
  useSafeAreaAndToolbar,

  /// `flexibleSpace` should occupy only toolbar
  useToolbar,

  /// `flexibleSpace` should NOT occupy neither safe area nor toolbar
  none;

  /// Pattern matching function by type. Executes the corresponding to the type
  /// callback, and returns the result of it
  R when<R>({
    required R Function() useSafeAreaAndToolbar,
    required R Function() useToolbar,
    required R Function() none,
  }) {
    switch (this) {
      case FlexibleSpaceMode.useSafeAreaAndToolbar:
        return useSafeAreaAndToolbar();
      case FlexibleSpaceMode.useToolbar:
        return useToolbar();
      case FlexibleSpaceMode.none:
        return none();
    }
  }
}
