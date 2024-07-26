import 'package:cuidapet_mobile/app/modules/address/address_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddressDetailModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => AddressPage(place: r.args.data));
  }
}
