import 'package:flutter/material.dart';

/// [ThemeExtensionColors] extension
extension ThemeExtensionColors on BuildContext {
  /// Calls [Theme.of(context).extension()] and ensures that it's not null
  /// by calling [ArgumentError.checkNotNull()].
  ///
  /// [name] parameter is optional,
  /// and is passed to [ArgumentError.checkNotNull()], and
  /// is used as the parameter "name" in the error message.
  T extensionColors<T extends ThemeExtension<T>>([String? name]) {
    return ArgumentError.checkNotNull(Theme.of(this).extension<T>(), name);
  }
}
