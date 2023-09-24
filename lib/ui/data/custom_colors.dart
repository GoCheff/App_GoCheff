import 'package:flutter/material.dart';

class CustomColors {
  static const Color primary = Color(0xff7e6641);
  static const Color secondary = Color(0xFFD68606);
  static const Color tertiary = Color(0xFFFFCB83);
  static const Color quaternary = Color(0xFFFFFAFA);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFF868686);
  static const Color transparent = Color(0x00000000);

  static const Color background = Color(0xfff2f2f2);
  static const Color error = Color(0xffd32f2f);
  static const Color success = Color(0xff388e3c);
  static const Color info = Color(0xff1976d2);

  static MaterialColor palette = MaterialColor(
    const Color.fromRGBO(212, 133, 6, 1.0).value,
    const <int, Color>{
      50: Color.fromRGBO(212, 133, 6, 0.1),
      100: Color.fromRGBO(212, 133, 6, 0.2),
      200: Color.fromRGBO(212, 133, 6, 0.3),
      300: Color.fromRGBO(212, 133, 6, 0.4),
      400: Color.fromRGBO(212, 133, 6, 0.5),
      500: Color.fromRGBO(212, 133, 6, 0.6),
      600: Color.fromRGBO(212, 133, 6, 0.7),
      700: Color.fromRGBO(212, 133, 6, 0.8),
      800: Color.fromRGBO(212, 133, 6, 0.9),
      900: Color.fromRGBO(212, 133, 6, 1.0),
    },
  );
}
