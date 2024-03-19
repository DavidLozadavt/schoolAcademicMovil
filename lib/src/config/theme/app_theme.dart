import 'package:flutter/material.dart';

const listColor = <Color>[
  Color(0xFF595959),
  Color(0xFF868686),
  Color(0xFFE8E8E8),
  Color(0xFFFFC403),
  Color(0xFF916700),
  Color(0xFF2E2E2E),
  Color(0xFF3E3E3E),
  Color(0xFF575757),
  Color(0xFFFFA603),
  Color(0xFFDD8A00),
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({this.selectedColor = 0, this.isDarkMode = false})
      : assert(selectedColor >= 0, 'Selected color must be greater than 0'),
        assert(selectedColor < listColor.length,
            'Selected color must be less than or equal than ${listColor.length - 1}');

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: listColor[selectedColor],
      brightness: isDarkMode ? Brightness.dark : Brightness.light);
}
