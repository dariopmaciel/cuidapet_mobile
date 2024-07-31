import 'package:cuidapet_mobile/app/modules/address/address_detail/address_detail_controller.dart';
import 'package:cuidapet_mobile/app/modules/address/address_detail/address_detail_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AddressDetailModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(AddressDetailController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => AddressDetailPage(place: r.args.data));
  }
}
