import 'package:cuidapet_mobile/app/core/database/sqlite_connection_factory.dart';
import 'package:flutter/widgets.dart';

//Ao fechar a conexão o flutter que está observando informa o status do ciclo de vida do app
class SqliteAdmConnection with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var connection = SqliteConnectionFactory();

    switch (state) {
      case AppLifecycleState.resumed:
        //voltou para o app
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        connection.closeConnection();
        break;
    }

    super.didChangeAppLifecycleState(state);
  }
}
