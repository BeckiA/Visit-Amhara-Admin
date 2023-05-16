import 'package:flutter/material.dart';

class VATextTheme {
  static TextTheme lightTextTheme = const TextTheme(
      // ignore: deprecated_member_use
      displayMedium: TextStyle(
        fontSize: 32,
        fontFamily: "Montserrat",
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      displayLarge: TextStyle(
        fontSize: 48,
        fontFamily: "Montserrat",
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      titleSmall:
          TextStyle(fontFamily: "Poppins", color: Colors.black54, fontSize: 28),
      titleMedium:
          TextStyle(fontFamily: "Poppins", color: Colors.black54, fontSize: 32),
      titleLarge: TextStyle(color: Colors.black));

  static TextTheme darkTextTheme = const TextTheme(
      displayMedium: TextStyle(
          fontFamily: "Montserrat",
          fontSize: 32,
          color: Colors.white70,
          fontWeight: FontWeight.bold),
      displayLarge: TextStyle(
        fontSize: 48,
        fontFamily: "Montserrat",
        color: Colors.white70,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
          fontFamily: "Montserrat", color: Colors.white60, fontSize: 28),
      titleMedium:
          TextStyle(fontFamily: "Poppins", color: Colors.white60, fontSize: 32),
      titleLarge: TextStyle(color: Colors.black));
}
