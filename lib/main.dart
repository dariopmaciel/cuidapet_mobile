import 'package:cuidapet_mobile/app/app_module.dart';
import 'package:cuidapet_mobile/app/app_widget.dart';
import 'package:cuidapet_mobile/app/core/application_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  //O 'AplicationConfig()' foi criado para encapsular as informações sencíveis de inicialização do app
  await ApplicationConfig().configureApp();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}


//PROXIMA AULA:
//-->Encapsulametno - Interface Restcliente