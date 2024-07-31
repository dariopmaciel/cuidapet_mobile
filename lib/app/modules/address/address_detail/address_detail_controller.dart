import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:mobx/mobx.dart';
part 'address_detail_controller.g.dart';

class AddressDetailController = AddressDetailControllerBase
    with _$AddressDetailController;

abstract class AddressDetailControllerBase with Store {
  final AddressService _addressService;

  AddressDetailControllerBase({
    required AddressService addressService,
  }) : _addressService = addressService;
}
