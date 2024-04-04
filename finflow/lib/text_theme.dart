import 'package:flutter/material.dart';

class TTextTheme {
  static TextTheme lightTextTheme = const TextTheme(
    displayMedium: TextStyle(fontFamily: 'Century', color: Colors.black87),
    displaySmall: TextStyle(
        fontFamily: 'Cera Pro', color: Colors.deepPurple, fontSize: 24),
  );
  static TextTheme darkTextTheme = const TextTheme(
    displayMedium: TextStyle(fontFamily: 'Century', color: Colors.white70),
    displaySmall:
        TextStyle(fontFamily: 'Cera Pro', color: Colors.white60, fontSize: 24),
  );
}
