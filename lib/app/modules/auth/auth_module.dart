import 'package:cuidapet_mobile/app/modules/auth/home/auth_home_page.dart';
import 'package:cuidapet_mobile/app/modules/auth/login/login_module.dart';
import 'package:cuidapet_mobile/app/modules/auth/register/register_module.dart';
import 'package:cuidapet_mobile/app/repositories/social/social_repository.dart';
import 'package:cuidapet_mobile/app/repositories/social/social_repository_impl.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository_impl.dart';
import 'package:cuidapet_mobile/app/services/user/user_service.dart';
import 'package:cuidapet_mobile/app/services/user/user_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        restClient: Modular.get(), //CoreModule
        log: Modular.get(), //CoreModule
      ),
    );
    i.addLazySingleton<UserService>(
      () => UserServiceImpl(
        log: Modular.get(), //CoreModule
        userRepository: Modular.get(), //AuthModule
        localStorage: Modular.get(),
        localSecureStorage: Modular.get(),
        socialRepository: Modular.get(),
      ),
    );
    i.addLazySingleton<SocialRepository>(SocialRepositoryImpl.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute,
        child: (_) => AuthHomePage(authStore: Modular.get()));
    r.module('/login/', module: LoginModule());
    r.module('/register/', module: RegisterModule());
  }
}
