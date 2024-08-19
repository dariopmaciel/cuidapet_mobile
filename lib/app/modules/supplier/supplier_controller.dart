// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';

import 'package:mobx/mobx.dart';

import 'package:cuidapet_mobile/app/services/supplier/supplier_service.dart';

part 'supplier_controller.g.dart';

class SupplierController = SupplierControllerBase with _$SupplierController;

abstract class SupplierControllerBase with Store, ControllerLifeCycle {
  final SupplierService _supplierService;
  final AppLogger _log;
  int _supplierId = 0;

  SupplierControllerBase({
    required SupplierService supplierService,
    required AppLogger log,
  })  : _supplierService = supplierService,
        _log = log;

// implementar metodo de inicialização
  @override
  void onInit([Map<String, dynamic>? params]) {
    //TESTE
    // print( 'PASSANDO: $params');
//--------------------F
    //uma vez que está s epassadno o parametro de id para prox pagina, se guarda ele
    // if (params != null) {
    //   _supplierId = params['supplierId'];
    // }
    //ou isto
    _supplierId = params?['supplierId'] ?? 0;
  }

// implementear metodo para quando a pagina for compilada (está pronta)
  @override
  void onReady() {}
}
