import 'package:finflow/utils/Colors/colors.dart';
import 'package:finflow/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    dividerColor: Colors.black,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        backgroundColor: const Color.fromRGBO(240, 240, 240, 1)),
    textTheme: TTextTheme.lightTextTheme,
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          CircleBorder(
            side: BorderSide(color: Color.fromARGB(255, 28, 30, 34)),
          ),
        ),
      ),
    ),
    appBarTheme:
        const AppBarTheme(backgroundColor: Color.fromRGBO(240, 240, 240, 1)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: const MaterialColor(
          0xFFA292F6, // Primary swatch color: Color.fromRGBO(162, 146, 246, 1)
          <int, Color>{
            50: Color.fromRGBO(162, 146, 246, 1),
            100: Color.fromRGBO(162, 146, 246, 1),
            200: Color.fromRGBO(162, 146, 246, 1),
            300: Color.fromRGBO(162, 146, 246, 1),
            400: Color.fromRGBO(162, 146, 246, 1),
            500: Color.fromRGBO(162, 146, 246, 1),
            600: Color.fromRGBO(162, 146, 246, 1),
            700: Color.fromRGBO(162, 146, 246, 1),
            800: Color.fromRGBO(162, 146, 246, 1),
            900: Color.fromRGBO(162, 146, 246, 1),
          },
        ),
        backgroundColor: const Color.fromARGB(255, 28, 30, 34)),
    textTheme: TTextTheme.darkTextTheme,
    appBarTheme: AppBarTheme(backgroundColor: grey),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          CircleBorder(
            side: BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
          ),
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      modalBackgroundColor: Color.fromRGBO(38, 47, 56, 1),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(13)),
        ),
      ),
    ),
  );
}
