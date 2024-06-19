import 'package:cuidapet_mobile/app/modules/auth/register/register_controller.dart';
import 'package:cuidapet_mobile/app/modules/auth/register/register_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class RegisterModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(
      //NÃO FUNCIONA :-(
      // () => RegisterController(userService: i(), log: i()),
      //FUNCIONA :-)
      () => RegisterController(userService: Modular.get(), log: Modular.get()),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const RegisterPage());
  }
}
