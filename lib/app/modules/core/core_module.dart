import 'package:cuidapet_mobile/app/core/database/sqlite_connection_factory.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage/flutter_secure_storage_local_storage_impl.dart';
import 'package:cuidapet_mobile/app/core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/logger/logger_app_logger_impl.dart';
import 'package:cuidapet_mobile/app/core/rest_client/dio/dio_rest_cliente.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
// import 'package:cuidapet_mobile/app/modules/address/address_detail/address_detail_controller.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:cuidapet_mobile/app/repositories/social/social_repository.dart';
import 'package:cuidapet_mobile/app/repositories/social/social_repository_impl.dart';
// import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(AuthStore.new);
    i.addLazySingleton<AppLogger>(LoggerAppLoggerImpl.new);
    i.addLazySingleton<LocalStorage>(SharedPreferencesLocalStorageImpl.new);
    i.addLazySingleton<LocalSecureStorage>(FlutterSecureStorageLocalStorageImpl.new);
    i.addLazySingleton<RestClient>(DioRestClient.new);
    i.addLazySingleton<SocialRepository>(SocialRepositoryImpl.new);
    //!-------------------------
    // i.addLazySingleton<AddressRepository>(AddressRepositoryImpl.new);
    // i.addLazySingleton<AddressService>(AddressServiceImpl.new);
    // i.addLazySingleton<AddressService>((i)=>AddressServiceImpl(addressRepository: Modular.get()));
    //
    // i.addLazySingleton(AddressSearchController.new);
    //!-------------------------
    i.addLazySingleton(SqliteConnectionFactory.new);
  }

  @override
  void exportedBinds(Injector i) {
    //   //! ESTES 4 ITENS AQUI "The injector(tag: CoreModule_Imported) is not committed."
    //   AuthStore(localStorage: i());
    //   DioRestClient(localStorage: i(), log: i(), authStore: i(), localSecureStorage: i());
    //   //! ATE AQUI
    //   LoggerAppLoggerImpl();
    //   SharedPreferencesLocalStorageImpl();
    //   FlutterSecureStorageLocalStorageImpl();
    //   SocialRepositoryImpl();
    //!-------------------------
    // AddressRepositoryImpl();
    // AddressServiceImpl(addressRepository: i());
  }
}
