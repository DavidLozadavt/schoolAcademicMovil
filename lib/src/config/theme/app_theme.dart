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
  //Colors web
  Color(0xFFE8E8E8),
  Color(0xFF707E97),
  Color(0xFFDFEBFF),
  Color(0xFF041447),
  Color(0xFF313E68),
  Color(0xFFFF6706),
  Color(0xFFC63B07),
  Color(0xFFF8F8FF),
  Color(0xFFFFC402),
  Color(0XFF5D6B89),
  Color(0XFF1E293B)
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
        brightness: Brightness.light,
        // colorScheme: const ColorScheme.dark(
        //   background: Colors.black,
        //   primary: Colors.grey,
        //   secondary: Colors.grey,
        // ),
      );
}
