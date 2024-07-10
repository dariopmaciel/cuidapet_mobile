import 'package:cuidapet_mobile/app/modules/auth/login/login_controller.dart';
import 'package:cuidapet_mobile/app/modules/auth/login/login_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(
      () => LoginController(
        userService: Modular.get(),
        log: Modular.get(),
      ),
    );
    
  }

  @override
  void routes(RouteManager r) {
    //  r.child(Modular.initialRoute, child: (_) =>  LoginPage());
    r.child(Modular.initialRoute, child: (_) => const LoginPage());
  }
}
