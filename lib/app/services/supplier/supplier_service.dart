import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';

abstract interface class SupplierService {

Future<List<SupplierCategoryModel>> getCategories();


Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity address);

}