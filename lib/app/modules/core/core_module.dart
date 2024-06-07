import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/logger/logger_app_logger_impl.dart';
import 'package:cuidapet_mobile/app/core/rest_client/dio/dio_rest_cliente.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';

import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(AuthStore.new);
    i.addLazySingleton<RestClient>(DioRestCliente.new);
    i.addLazySingleton<AppLogger>(LoggerAppLoggerImpl.new);
    
    // super.binds(i);
  }

  @override
  void exportedBinds(Injector i) {
    super.exportedBinds(i);
    AuthStore();
    DioRestCliente();
    LoggerAppLoggerImpl();
  }
}
