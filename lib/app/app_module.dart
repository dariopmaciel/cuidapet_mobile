import 'package:cuidapet_mobile/app/modules/auth/auth_module.dart';
// import 'package:cuidapet_mobile/app/modules/auth/home/auth_home_page.dart';
import 'package:cuidapet_mobile/app/modules/auth/register/register_module.dart';

import 'package:cuidapet_mobile/app/modules/core/core_module.dart';
import 'package:cuidapet_mobile/app/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void routes(r) {
    r.module('/auth/', module: AuthModule());
    r.module('/home/', module: HomeModule());
    r.module('/register/', module: RegisterModule());
  }

  //EXEMPLO JÁ APLICADO

  //void binds(i) {}
  // void routes(RouteManager r) {
  // r.child(Modular.initialRoute, child: (context) => const SplashPage());
  //ou
  //   r.child('/', child: (context) => const SplashPage());

  //sem passagem de argumento para o modulo
  //   r.module('/categoria', module: CategoriaModule());

  //com passagem de argumento para o modulo
  // r.child('/categoria', child: (context) => CategoriaPage(categoria: 'CASA'));

  //COM RECUPERAÇÃO DE ARGUMENTO para o modulo
  // r.child('/categoria',
  //     child: (context) => CategoriaPage(categoria: r.args.data));
  //   r.module('/produto', module: ProdutoModule());

  //   super.routes(r);
  // }

  // void binds(i) {
  //   i.addLazySingleton(AuthStore.new);
  // }
}
