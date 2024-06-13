import 'package:cuidapet_mobile/app/modules/auth/home/auth_home_page.dart';
import 'package:cuidapet_mobile/app/modules/auth/login/login_module.dart';

import 'package:cuidapet_mobile/app/modules/auth/register/register_module.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository_impl.dart';
import 'package:cuidapet_mobile/app/services/user/user_service.dart';
import 'package:cuidapet_mobile/app/services/user/user_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<UserRepository>(UserRepositoryImpl.new);
    i.addLazySingleton<UserService>(UserServiceImpl.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(
      Modular.initialRoute,
      child: (_) => AuthHomePage(authStore: Modular.get()),
    );
    r.module('/login/', module: LoginModule());
    r.module('/register/', module: RegisterModule());
  }
}
