//fu-mobx-store para criar o .g
import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {
  // @override
  // void onInit([Map<String, dynamic>? params]) {
  //   print("onInit chamada");
  //   // print(params);
  //   super.onInit(params);
  // }

  @override
  Future<void> onReady() async {
    // print("onReady chamada");
    await _hasRegisteredAddress();
  }

//Verifica se o usuário tem endereço cadastrado
  Future <void>_hasRegisteredAddress() async {
    await Modular.to.pushNamed('/address');
  }
}
