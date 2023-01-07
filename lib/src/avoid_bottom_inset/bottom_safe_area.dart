import 'package:flutter/widgets.dart';

/// {@template re_seedwork.widgets.bottomSafeArea}
/// Invisible widget, height of which equals to
/// [MediaQuery.of(context).padding.bottom)]
/// {@endtemplate}
class BottomSafeArea extends StatelessWidget {
  /// Creates an
  /// {@macro re_seedwork.widgets.bottomSafeArea}
  const BottomSafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).padding.bottom);
  }
}
