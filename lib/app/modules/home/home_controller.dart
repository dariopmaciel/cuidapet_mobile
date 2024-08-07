//fu-mobx-store para criar o .g
import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/messages.dart';
import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:cuidapet_mobile/app/services/supplier/supplier_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {
  final AddressService _addressService;
  final SupplierService _supplierService;

  @readonly
  AddressEntity? _addressEntity;
  @readonly
  var _listCategories = <SupplierCategoryModel>[];

  HomeControllerBase({
    required AddressService addressService,
    required SupplierService supplierService,
  })  : _addressService = addressService,
        _supplierService = supplierService;

  @override
  Future<void> onReady() async {
    try {
      // print("onReady chamada");
      // await _hasRegisteredAddress();
      Loader.show();
      //1-identificar se o usuário tem algum endereço selecionado
      //2-se tiver-recuperar ele
      await _getAddressSelected();
      await _getCategories();
    } finally {
      // o finally sempre executa;;; neste caso esconde o show.hide
      Loader.hide();
    }
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
    if (address != null) {
      _addressEntity = address;
    }
  }

  Future<void> _getCategories() async {
    try {
      final categories = await _supplierService.getCategories();
      _listCategories = [...categories];
    } catch (e) {
      Messages.alert("Erro ao buscar as categorias");
      throw Exception();
    }
  }
}
