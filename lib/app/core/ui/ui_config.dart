import 'package:flutter/material.dart';

class UiConfig {
  //Um construtor privado evita o acesso desta classe e
  //eles não existirem, pq só existem metodos estáticos

  //! EVITA LAMBANÇA
  UiConfig._();

  // ignore: non_constant_identifier_names
  static String get Title => "CuidaPet";
  static ThemeData get theme => ThemeData(
        primaryColor: const Color(0xffa8ce4b),
        primaryColorDark: const Color(0xff689f38),
        primaryColorLight: const Color(0xffdde9c7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffa8ce4b),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 30
          ),
        ),
      );
}
