import 'package:flutter/material.dart';


class UiConfig {
  UiConfig._();

  static String get title => "CuidaPet";

  static ThemeData get theme => ThemeData(
        // useMaterial3: true,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        primaryColor: const Color(0xFFA8CE4B),
        primaryColorDark: const Color(0xFF689F38),
        primaryColorLight: const Color(0xFFDDE9C7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFA8CE4B),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 26,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      );
}
