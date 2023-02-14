import 'package:flutter/material.dart';

/// [ShowSnackBarExtension] extension
extension ShowSnackBarExtension on BuildContext {
  /// Calls [ScaffoldMessenger.of(context).showSnackBar()]
  Future<SnackBarClosedReason> showSnackBar(
    String text, {
    SnackBarAction? action,
    Color? backgroundColor,
  }) async {
    return ScaffoldMessenger.of(this)
        .showSnackBar(
          SnackBar(
            content: Text(text),
            action: action,
            backgroundColor: backgroundColor,
          ),
        )
        .closed;
  }
}
