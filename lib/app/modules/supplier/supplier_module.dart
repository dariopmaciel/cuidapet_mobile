import 'package:cuidapet_mobile/app/modules/core/supplier/supplier_core_module.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SupplierModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton(SupplierController.new);
    // i.addLazySingleton((i) => SupplierController(supplierService: i(), log: i()));
    i.addLazySingleton(() => SupplierController(supplierService: Modular.get(), log: Modular.get()));
    super.binds(i);
  }

  @override
  List<Module> get imports => [
        SupplierCoreModule(),
      ];

  @override
  void routes(r) {
    r.child('/', child: (_) => SupplierPage(supplierId: Modular.args.data));
  }
}
