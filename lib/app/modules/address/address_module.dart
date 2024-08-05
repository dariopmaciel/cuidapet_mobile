import 'package:cuidapet_mobile/app/core/database/sqlite_connection_factory.dart';
import 'package:cuidapet_mobile/app/modules/address/address_controller.dart';
import 'package:cuidapet_mobile/app/modules/address/address_detail/address_detail_module.dart';
import 'package:cuidapet_mobile/app/modules/address/address_page.dart';
import 'package:cuidapet_mobile/app/modules/address/widgets/address_search_widget/address_search_controller.dart';
import 'package:cuidapet_mobile/app/repositories/address/address_repository.dart';
import 'package:cuidapet_mobile/app/repositories/address/address_repository_impl.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:cuidapet_mobile/app/services/address/address_service_impl.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AddressModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<AddressService>(() => AddressServiceImpl(
        addressRepository: Modular.get(), localStorage: Modular.get()));
    i.addLazySingleton<AddressRepository>(AddressRepositoryImpl.new);
    // i.addLazySingleton((i)=>AddressSearchController(addressService: Modular.get())); // não funciona
    // i.addLazySingleton((i) => AddressSearchController(addressService: i())); // não funciona
    i.addLazySingleton(AddressSearchController.new);
    i.addLazySingleton(SqliteConnectionFactory.new);
    //!--------------------------------------------------------
    //talvez seja necessário Modular.get()
    i.addLazySingleton(AddressController.new);
    //ou assim
    // i.addLazySingleton(()=> AddressController());
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute,
        child: (context) => AddressPage(place: r.args.data));
    r.module('/detail/', module: AddressDetailModule());

    super.routes(r);
  }
}
