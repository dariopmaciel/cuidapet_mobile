import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';

abstract interface class AddressService {
  Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern);
  Future<List<AddressEntity>> getAddress();
  Future<void> deleteAll();
  Future<AddressEntity> saveAddress(PlaceModel placeModel, String additional);
  Future<void> selectAdress(AddressEntity addressEntity);
  Future<AddressEntity?> getAddressSelected();
}
