import 'package:cuidapet_mobile/app/modules/address/address_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddressModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton<>();
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (context) => const AddressPage(),
    );
    super.routes(r);
  }
}
