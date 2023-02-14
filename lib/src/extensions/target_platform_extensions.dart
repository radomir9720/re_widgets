import 'package:flutter/material.dart';

/// [TargetPlatformPatternMatchExtension] extension
extension TargetPlatformPatternMatchExtension on TargetPlatform {
  /// Pattern matching function by type. Executes the corresponding to the type
  /// callback, and returns its result.
  T when<T>({
    required T Function() android,
    required T Function() fuchsia,
    required T Function() iOS,
    required T Function() linux,
    required T Function() macOS,
    required T Function() windows,
  }) {
    switch (this) {
      case TargetPlatform.android:
        return android();
      case TargetPlatform.fuchsia:
        return fuchsia();
      case TargetPlatform.iOS:
        return iOS();
      case TargetPlatform.linux:
        return linux();
      case TargetPlatform.macOS:
        return macOS();
      case TargetPlatform.windows:
        return windows();
    }
  }

  /// Pattern matching function by type. Executes the corresponding to the type
  /// callback, and returns the result of it.
  ///
  /// `orElse` callback is executed and its result is returned if the
  /// corresponding to the type callback was not specified.
  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? android,
    T Function()? fuchsia,
    T Function()? iOS,
    T Function()? linux,
    T Function()? macOS,
    T Function()? windows,
  }) {
    switch (this) {
      case TargetPlatform.android:
        return android?.call() ?? orElse();
      case TargetPlatform.fuchsia:
        return fuchsia?.call() ?? orElse();
      case TargetPlatform.iOS:
        return iOS?.call() ?? orElse();
      case TargetPlatform.linux:
        return linux?.call() ?? orElse();
      case TargetPlatform.macOS:
        return macOS?.call() ?? orElse();
      case TargetPlatform.windows:
        return windows?.call() ?? orElse();
    }
  }

  /// Returns true if the current platform is android
  bool get isAndroid => this == TargetPlatform.android;

  /// Returns true if the current platform is fuchsia
  bool get isFuchsia => this == TargetPlatform.fuchsia;

  /// Returns true if the current platform is iOS
  bool get isIos => this == TargetPlatform.iOS;

  /// Returns true if the current platform is linux
  bool get isLinux => this == TargetPlatform.linux;

  /// Returns true if the current platform is macOS
  bool get isMacOS => this == TargetPlatform.macOS;

  /// Returns true if the current platform is windows
  bool get isWindows => this == TargetPlatform.windows;
}

/// [PlatformExtension] extension
extension PlatformExtension on BuildContext {
  /// Calls [Theme.of(context).platform]
  TargetPlatform get platform => Theme.of(this).platform;
}
