import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';


abstract class AddressRepository {
  Future<List<PlaceModel>> findAddressGooglePlaces(String addressPattern);

  Future<List<AddressEntity>> getAddress();

  Future<int> saveAddress(AddressEntity entity);

  Future<void> deleteAll();
}
