//fu-mobx-store para criar o .g
import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {
  // @override
  // void onInit([Map<String, dynamic>? params]) {
  //   print("onInit chamada");
  // print(params);
  //   super.onInit(params);
  // }
  @readonly
  AddressEntity? _addressEntity;
  final AddressService _addressService;

  HomeControllerBase({
    required AddressService addressService,
  }) : _addressService = addressService;

  @override
  Future<void> onReady() async {
    // print("onReady chamada");
    // await _hasRegisteredAddress();
    Loader.show();
    //1-identificar se o usuário tem algum endereço selecionado
    //2-se tiver-recuperar ele
    await _getAddressSelected();

    Loader.hide();
  }

//Verifica se o usuário tem endereço cadastrado
  // Future <void>_hasRegisteredAddress() async {
  // await Modular.to.pushNamed('/address/');
  // }
  @action
  Future<void> _getAddressSelected() async {
    // if (_addressEntity == null) {
    //   _addressEntity = await _addressService.getAddressSelected();
    // }
    //igual ao de baixo
    _addressEntity ??= await _addressService.getAddressSelected();

    if (_addressEntity == null) {
      await goToAddressPage();
    }
  }

  @action
  Future<void> goToAddressPage() async {
    final address = await Modular.to.pushNamed<AddressEntity>('/address/');
    
    _addressEntity = address;
  }
}
