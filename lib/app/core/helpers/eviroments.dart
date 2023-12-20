import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroments {
  Enviroments._();

  static String? param(String paramName) {
    return dotenv.env[paramName];
  }

  static Future<void> loadEnvs() async {
    await dotenv.load(fileName: ".env");
  }
}
