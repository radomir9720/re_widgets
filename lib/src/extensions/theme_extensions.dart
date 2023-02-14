import 'package:flutter/material.dart';
import 'package:re_seedwork/re_seedwork.dart';

/// [ThemeExtensionColors] extension
extension ThemeExtensionColors on BuildContext {
  /// Calls [Theme.of(context).extension()] and ensures that it's not null
  /// by calling [ArgumentError.checkNotNull()].
  ///
  /// [name] parameter is optional,
  /// and is passed to [ArgumentError.checkNotNull()], and
  /// is used as the parameter "name" in the error message.
  T extensionColors<T extends ThemeExtension<T>>([String? name]) {
    return Theme.of(this).extension<T>().checkNotNull(name);
  }
}
