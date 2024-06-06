import 'package:cuidapet_mobile/app/core/rest_client/dio/dio_rest_cliente.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';

import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(AuthStore.new);
    i.addLazySingleton(DioRestCliente.new);
    // super.binds(i);
  }

  @override
  void exportedBinds(Injector i) {
    super.exportedBinds(i);
    AuthStore();
    DioRestCliente();
  }
}
