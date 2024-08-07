import 'package:asuka/asuka.dart';
import 'package:cuidapet_mobile/app/core/database/sqlite_adm_connection.dart';
import 'package:cuidapet_mobile/app/core/ui/ui_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  //Observador ADM de conexão
  final sqliteAdmConnection = SqliteAdmConnection();
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/auth/');
    //*OBSERVAÇÃO-> ADD conforme DOCUMENTAÇÃO. Passando um array com os Obervadores nas rotas, pois o mesmo não funciona facilmente com 'Modular'
    Modular.setObservers([Asuka.asukaHeroController]);
    //*-----------------------------------------
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp.router(
        title: UiConfig.title,

        //This line is needed for the Hero widget to work
        // Alterado para que funcione
        // navigatorObservers: [Asuka.asukaHeroController],
        debugShowCheckedModeBanner: false,
        // builder: (context, child) {
        //   return Asuka.builder(context, child);
        // },
        // substituido por:
        builder: Asuka.builder,
        theme: UiConfig.theme,
        // theme: ThemeData(primarySwatch: Colors.blue),
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}
