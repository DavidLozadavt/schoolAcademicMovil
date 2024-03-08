import 'package:flutter/services.dart';

class DirectionFormatText extends TextInputFormatter {
  static String oldText = "";
  // con este toca jugar
  static String direction = "";
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    formatingDirection(newValue.text);

    return newValue.copyWith(text: newValue.text.toUpperCase());
  }

  void formatingDirection(String textToFormat) {
    if (textToFormat.isNotEmpty) {
      if (!(textToFormat.length > 2 && oldText == textToFormat)) {
        oldText = textToFormat;
        textToFormat = textToFormat.trim();
        textToFormat = textToFormat.replaceAll("/[ ]+/g", " ");
        textToFormat = textToFormat.toUpperCase();
        direction = parseDirection(textToFormat);
        //print(direction);
      }
    }
  }
}

String parseDirection(String direction) {
  if (direction.isEmpty || direction.trim() == "") {
    return "";
  }
  String dir = "";
  RegExp exp = RegExp(r'([0-9]+[ A-Z]{0,})');
  Iterable<RegExpMatch> numbs = exp.allMatches(direction);
  final parts = direction.split(' ');
  final type = parts[0];

  // Modifica la calle y carrera,
  // OBS: si se va a implementar avenida se tiene que modificar el if

  if (type.contains("C")) {
    if (type.contains("R")) {
      dir = "CR ";
    } else {
      dir = "CL ";
    }
  }
  else if (type.contains("T"))  {
    dir = 'TV ';
  }
  else if (type.contains("D"))  {
    dir = 'DG ';
  }
  else if (type.contains("A")) {
    dir = "AV ";
  }
  else {
    dir = '$type ';
  }

  if (numbs.isNotEmpty) {
    int i = 0;
    for (final m in numbs) {
      switch (i) {
        case 0:
          dir += "${m[0].toString().trim()} # ";
          break;
        case 1:
          dir += "${m[0].toString().trim()} - ";
          break;
        default:
          dir += m[0].toString();
      }
      i++;
    }
  }

  return dir.replaceAll("/[ ]+/g", ' ').trim();
}

class UpperCaseText extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}
