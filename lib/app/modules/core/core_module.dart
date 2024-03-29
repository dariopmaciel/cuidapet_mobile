import 'package:cuidapet_mobile/app/core/local_storage/flutter_secure_store/flutter_secure_store_local_store_impl.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/logger/logger_app_logger_impl.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/dio/dio_rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';


class CoreModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(AuthStore.new);
    // i.addInstance(AuthStore());
    i.addLazySingleton<RestClient>(DioRestClient.new);
    i.addLazySingleton<AppLogger>(LoggerAppLoggerImpl.new);
    i.addLazySingleton<LocalStorage>(SharedPreferencesLocalStorageImpl.new);
    i.addLazySingleton<LocalSecureStorage>(FlutterSecureStoreLocalStoreImpl.new);
  }

  @override
  void exportedBinds(Injector i) {
    super.exportedBinds(i);
    AuthStore();
    DioRestClient();
    LoggerAppLoggerImpl();
    SharedPreferencesLocalStorageImpl();
    FlutterSecureStoreLocalStoreImpl();
    
  }

  // @override
  // void routes(r) {
  // r.child(Modular.initialRoute, child: (context) => const AuthHomePage());
  // }
}
//EXEMPLO JÁ APLICADO
  // void routes(RouteManager r) {
  // r.child(Modular.initialRoute, child: (context) => const SplashPage());
  //ou
  //   r.child('/', child: (context) => const SplashPage());

  //sem passagem de argumento para o modulo
  //   r.module('/categoria', module: CategoriaModule());

  //com passagem de argumento para o modulo
  // r.child('/categoria', child: (context) => CategoriaPage(categoria: 'CASA'));

  //COM RECUPERAÇÃO DE ARGUMENTO para o modulo
  // r.child('/categoria',
  //     child: (context) => CategoriaPage(categoria: r.args.data));
  //   r.module('/produto', module: ProdutoModule());

  //   super.routes(r);
  // }