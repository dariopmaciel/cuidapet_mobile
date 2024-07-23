import 'package:cuidapet_mobile/app/models/place_model.dart';

abstract interface class AddressService {
Future<List<PlaceModel>> findaddressByGooglePlaces(String addressPattern);
}