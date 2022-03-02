import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUiConfig {
  TodoListUiConfig._();
  static ThemeData theme() => ThemeData(
        primaryColor: const Color(0xff5C77CE),
        primaryColorLight: const Color(0xff5C77CE),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff5C77CE),
          ),
        ),
        textTheme: GoogleFonts.mandaliTextTheme(),
      );
}
