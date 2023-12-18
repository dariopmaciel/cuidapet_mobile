import 'package:cuidapet_mobile/app/core/ui/ui_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:asuka/asuka.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // serve para iniciar o app
    Modular.setInitialRoute('/auth/');
    //OBSERVAÇÃO alterado da DOCUMENTAÇÃO para que funcione pois o mesmo não fiunciona facilmente com 'Modular'
    Modular.setObservers([Asuka.asukaHeroController]);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp.router(
        title: UiConfig.Title,
        //This line is needed for the Hero widget to work
        // Alterado para que funcione
        // navigatorObservers: [Asuka.asukaHeroController],
        debugShowCheckedModeBanner: false,
        // builder: 
        // (context, child) {
        //   return Asuka.builder(context, child);
        // },
        // substituido por:
        builder: Asuka.builder,
        theme: UiConfig.theme,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}
