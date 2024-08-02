import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
part 'address_controller.g.dart';

class AddressController = AddressControllerBase with _$AddressController;

abstract class AddressControllerBase with Store, ControllerLifeCycle {
  final AddressService _addressService;

  @readonly
  List<AddressEntity> _address = [];

  @readonly
  bool _locationServiceInavailable = false;
  @readonly
  LocationPermission? _locationPermition;

  AddressControllerBase({
    required AddressService addressService,
  }) : _addressService = addressService;

  @override
  void onReady() {
    getAddresses();
  }

  @action
  Future<void> getAddresses() async {
    Loader.show();
    _address = await _addressService.getAddress();
    Loader.hide();
  }

  @action
  Future<void> myLocation() async {
    //perguntar ao packegeo se temos permissão para fazer busca de localização
    final serviceEnable = await Geolocator.isLocationServiceEnabled();
    //se não tiver ativo
    if (!serviceEnable) {
      _locationServiceInavailable = true;
      return; //forma d eparar execução
    }
    //checar quais permissões temos para o app
    final locationPermission = await Geolocator.checkPermission();
    switch (locationPermission) {
      case LocationPermission.denied:
        //se for negado
        final permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          _locationPermition = permission;
          return;
        }
        break;
      case LocationPermission.deniedForever:
        //se for negado para sempre
        _locationPermition = locationPermission;
        return;
      case LocationPermission.whileInUse:
      case LocationPermission.always:
      case LocationPermission.unableToDetermine:
        break;
    }
  }
}
