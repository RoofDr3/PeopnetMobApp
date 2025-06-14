import 'package:flutter/material.dart';
import 'package:peopnet/core/theme/app_pallete.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(width: 2, color: color),
    borderRadius: BorderRadius.circular(10),
  );
  // ignore: non_constant_identifier_names
  static final OrangeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color.fromRGBO(212, 215, 253, 1),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: _border(const Color.fromARGB(255, 32, 2, 163)),
      enabledBorder: _border(Pallete.gradient1),
    ),
  );

  // ignore: non_constant_identifier_names
  static final FontFamily = ThemeData(fontFamily: 'Cabin');
}
