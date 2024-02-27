import 'package:flutter/material.dart';

const kTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

const kTitleStyleDark = TextStyle(
  color: Colors.black,
  fontFamily: 'CM Sans Serif',
  fontSize: 16.0,
  height: 1.5,
);
const kTitleStylew = TextStyle(
  color: Colors.black,
  fontFamily: 'CM Sans Serif',
  fontSize: 24.0,
  height: 1.5,
);
const kTitleStylewAmber = TextStyle(
  color: Colors.amber,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

const kTitleStyleBlack = TextStyle(
  color: Colors.black,
  fontFamily: 'Averta_Black_Italic',
  fontSize: 26.0,
  height: 1.5,
);

const kTitleStyLongText = TextStyle(
  color: Colors.white,
  fontFamily: 'CM Sans Serif',
  fontSize: 15.0,
  height: 1.5,
);
const k1SubtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  height: 1.2,
);
const k1SubtitleStyles = TextStyle(
  color: Colors.black,
  fontSize: 18.0,
  height: 1.2,
);

const kTlight = TextStyle(
    color: Colors.black,
    fontFamily: 'Averta_Light',
    fontSize: 13.0,
    height: 1.5,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.bold);
//principalLetra
const kTlightpro = TextStyle(
    color: Colors.black,
    fontFamily: 'Averta_Light',
    fontSize: 20.0,
    height: 1.5,
    fontWeight: FontWeight.bold);

var kTlightproMax = const TextStyle(
    color: Colors.black,
    fontFamily: 'Averta_Light',
    fontSize: 20.0,
    height: 1.5,
    fontWeight: FontWeight.bold);

const kTlightpromin = TextStyle(
     decoration: TextDecoration.none,
    color: Colors.black,
    fontFamily: 'Averta_Light',
    fontSize: 14.0,
    height: 1.5,
    fontWeight: FontWeight.bold);

const kTlightpromin2 = TextStyle(
    color: Colors.black,
    fontFamily: 'Averta_Light',
    fontSize: 8.0,
    height: 1.5,
    fontWeight: FontWeight.bold);

const kTlightpromin3 = TextStyle(
    color: Colors.black,
    fontFamily: 'Averta_Light',
    fontSize: 12.0,
    height: 1.5,
    fontWeight: FontWeight.bold);

const kTlightproSmall = TextStyle(
    color: Colors.black,
    fontFamily: 'Averta_Light',
    fontSize: 12.0,
    height: 1.5,
    fontWeight: FontWeight.bold);

InputDecoration kInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    contentPadding:
        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  );
}

InputDecoration kInputDecoration2() {
  return InputDecoration(
    contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  );
}

InputDecoration kInputDecorations(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.all(10),
      border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black)));
}

TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
            (states) => const Color.fromARGB(255, 226, 153, 17)),
        padding: MaterialStateProperty.resolveWith(
            (states) => const EdgeInsets.symmetric(vertical: 10))),
    onPressed: () => onPressed(),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

// loginRegisterHint
Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
          child: Text(label, style: const TextStyle(color: Colors.blue)),
          onTap: () => onTap())
    ],
  );
}

const kCategoryCardImageSize = 120.0;
