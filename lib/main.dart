import 'package:cuidapet_mobile/app/app_module.dart';
import 'package:cuidapet_mobile/app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Future<void> initializeDefault() async {
  //   FirebaseApp app = await Firebase.initializeApp(
  //       options: DefaultFirebaseOptions.currentPlatform);
  //   print('Initialized default app $app');
  // }

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
