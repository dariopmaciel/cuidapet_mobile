import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:cuidapet_mobile/app/modules/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {

   @override
  void binds(i) {
    i.addSingleton(HomeController.new);
  }

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (_) => const HomePage());
  }

}


//EXEMPLO JÁ APLICADO
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