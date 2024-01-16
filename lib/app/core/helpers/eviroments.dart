import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroments {
  Enviroments._();

  static String? param(String paramName) {
    // modo DEBUG
    if (kReleaseMode) {
      // NÃO modo DEBUG
      // if (!kReleaseMode) {
      return FirebaseRemoteConfig.instance.getString(paramName);
    } else {
      return dotenv.env[paramName];
    }
  }

//controle dos modos RELEASE E MODO DEBUG
  static Future<void> loadEnvs() async {
    // se for produção - modo DEBUG
    if (kReleaseMode) {
      // NÃO modo DEBUG
      // if (!kReleaseMode) {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout:
              const Duration(minutes: 1), //busca de cache de 1 min em 1 min
          minimumFetchInterval: const Duration(hours: 1), //cache 1h
        ),
      );
      //* FUNDAMENTAL: Este item abaixo BUSCA OS DADOS
      await remoteConfig.fetchAndActivate();
    } else {
      await dotenv.load(fileName: ".env");
    }
  }
}
