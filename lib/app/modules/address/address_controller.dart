import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
part 'address_controller.g.dart';

class AddressController = AddressControllerBase with _$AddressController;

abstract class AddressControllerBase with Store, ControllerLifeCycle {
  final AddressService _addressService;

  @readonly
  // List<AddressEntity> _address = [];
  //não pode ser List por causa do mobx não funciona, por isto precisa alterar
  var _address = <AddressEntity>[];

  @readonly
  // bool _locationServiceInavailable = false;
  //não pode ser bool por causa do mobx não funciona, por isto usar var + obs()
  // var _locationServiceInavailable = false.obs();
  var _locationServiceInavailable = false;

  @readonly
  LocationPermission? _locationPermition;
  @readonly
  PlaceModel? _placemodel;

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
    _locationPermition = null;
    _locationServiceInavailable = false;

    //perguntar ao packegeo se temos permissão para fazer busca de localização
    final serviceEnable = await Geolocator.isLocationServiceEnabled();
    //se não tiver ativo
    if (!serviceEnable) {
      // _locationServiceInavailable = true;
      // por causa do MOBX precisa add .obs()
      // _locationServiceInavailable = true.obs();
      _locationServiceInavailable = true;
      return; //forma d eparar execução
    }
    //checar quais permissões temos para o app
    final locationPermission = await Geolocator.checkPermission();
    switch (locationPermission) {
      case LocationPermission.denied:
        final permission = await Geolocator.requestPermission();
        //se for negado
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
    //buscar localização

    Loader.show();
    //dependendo da posição/local onde se está, se define o 'desiredAccuracy'
    //Longitude e latitude
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final place = placemark.first;
    //montar endereço com interpolação
    final address = '${place.thoroughfare} ${place.subThoroughfare}';
    final placeModel = PlaceModel(
        address: address, lat: position.latitude, lng: position.longitude);

    Loader.hide();
    goToAddressDetail(placeModel);
  }

  Future<void> goToAddressDetail(PlaceModel place) async {
    final address =
        await Modular.to.pushNamed('/address/detail/', arguments: place);
    if (address is PlaceModel) {
      _placemodel = address;
    }
  }
}
