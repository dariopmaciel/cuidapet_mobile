import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  //*Permite subistituir
  //!'backgroundColor: Theme.of(context).primaryColor,'
  //*Por:
  //*'backgroundColor: context.primaryColor,'
  //*inserindo 'ThemeExtension' no arquivo desejado
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
