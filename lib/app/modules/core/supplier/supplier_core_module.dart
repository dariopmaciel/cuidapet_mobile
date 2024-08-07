import 'package:cuidapet_mobile/app/repositories/supplier/supplier_repository.dart';
import 'package:cuidapet_mobile/app/repositories/supplier/supplier_repository_impl.dart';
import 'package:cuidapet_mobile/app/services/supplier/supplier_service.dart';
import 'package:cuidapet_mobile/app/services/supplier/supplier_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SupplierCoreModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton<SupplierRepository>(SupplierRepositoryImpl.new);
    i.addLazySingleton<SupplierRepository>(() => SupplierRepositoryImpl(
        restClient: Modular.get(), logger: Modular.get()));
    // i.addLazySingleton<SupplierService>(SupplierServiceImpl.new);
    i.addLazySingleton<SupplierService>(
        () => SupplierServiceImpl(supplierRepository: Modular.get()));
    super.binds(i);
  }
}
