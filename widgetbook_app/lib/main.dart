import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookApp.material(
  name: 're_widgets',
  devices: [
    Apple.iPhoneSE2016,
    Apple.iPhoneSE2020,
    Apple.iPhone11ProMax,
    Apple.iPadPro12inch,
    Samsung.s10,
    Samsung.s21ultra,
  ],
)
class ReWidgetsApp {}

@WidgetbookTheme(name: 'Light', isDefault: true)
ThemeData getDarkTheme() => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: Colors.blueAccent,
        background: Colors.white,
        onPrimary: Colors.black,
      ),
    );

@WidgetbookTheme(name: 'Dark')
ThemeData getLightTheme() => ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      colorScheme: ColorScheme.dark(
        primary: Colors.blueAccent,
        onPrimary: Colors.white,
        background: Colors.grey.shade900,
      ),
    );
