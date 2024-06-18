import 'package:cuidapet_mobile/app/modules/auth/register/register_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'register_controller.dart';

class RegisterModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton(RegisterController.new);
    i.addLazySingleton(
      () => RegisterController(
        log: i(),
        userService: i(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const RegisterPage(),
    );
  }
}
