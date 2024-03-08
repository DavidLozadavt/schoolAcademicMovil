import 'package:flutter/material.dart';

const listColor = <Color>[
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.pink,
  Colors.teal,
  Colors.cyan,
  Colors.amber,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
  Colors.white,
];

class AppTheme {
  
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({this.selectedColor = 0, this.isDarkMode = false})
      : assert(selectedColor >= 0, 'Selected color must be greater than 0'),
        assert(selectedColor < listColor.length,
            'Selected color must be less than or equal than ${listColor.length -1}');

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: listColor[selectedColor],
        brightness:  isDarkMode ? Brightness.dark : Brightness.light
      );
}
