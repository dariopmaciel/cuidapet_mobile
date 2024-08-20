import 'package:cuidapet_mobile/app/modules/schedules/schedules_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SchedulesModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (args) => const SchedulesPage());
    super.routes(r);
  }
}
