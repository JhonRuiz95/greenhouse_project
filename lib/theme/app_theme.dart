import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Colors.blueAccent;
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    //Color Primario del tema
    primaryColor: primary,

    //Agregar de mas themas para la app
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: const Color.fromARGB(
            113, 17, 18, 30), //const Color.fromARGB(255, 173, 172, 172),
        shape: const StadiumBorder(),
        elevation: 0,
      ),
    ),
  );
}
