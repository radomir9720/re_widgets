import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template re_seedwork.widgets.annotatedRegionWrapper}
/// Wraps the screen body,
/// and applies to the status bar the brightness according to the theme
/// {@endtemplate}
class AnnotatedRegionWrapper extends StatelessWidget {
  /// Creates a widget that
  /// {@macro re_seedwork.widgets.annotatedRegionWrapper}
  const AnnotatedRegionWrapper({super.key, required this.child});

  /// Screen body
  @protected
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Theme.of(context)
            .appBarTheme
            .systemOverlayStyle
            ?.statusBarBrightness,
      ),
      child: child,
    );
  }
}
