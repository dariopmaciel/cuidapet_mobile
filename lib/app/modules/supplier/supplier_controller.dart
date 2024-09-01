// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/messages.dart';
import 'package:cuidapet_mobile/app/models/supplier_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_services_model.dart';
import 'package:cuidapet_mobile/app/modules/schedules/model/schedules_view_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';


import 'package:mobx/mobx.dart';

import 'package:cuidapet_mobile/app/services/supplier/supplier_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'supplier_controller.g.dart';

class SupplierController = SupplierControllerBase with _$SupplierController;

abstract class SupplierControllerBase with Store, ControllerLifeCycle {
  final SupplierService _supplierService;
  final AppLogger _log;
  int _supplierId = 0;

  @readonly
  SupplierModel? _supplierModel;
  @readonly
  var _supplierServices = <SupplierServicesModel>[];

  @readonly
  var _servicesSelected = <SupplierServicesModel>[]
      .asObservable(); //transforma em uma lista observavel

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
  Future<void> onReady() async {
    //interação com usuário//buscar os dados
    try {
      Loader.show();
      //!O FUTURE.WAIT PERMITE QUE AMBAS FUNCIONEM AO MESMO TEMPO!!!!
      await Future.wait([
        //buscar detalhes do fornecedor em paralelo com a próxima
        _findSupplierById(),
        //buscar serviços do fornecedor em paralelo com a anterior
        _findSupplierServices(),
      ]);
    } finally {
      Loader.hide();
    }
  }

  @action
  Future<void> _findSupplierById() async {
    try {
      _supplierModel = await _supplierService.findById(_supplierId);
    } catch (e, s) {
      _log.error("Erro ao buscar DADOS do fornecedor", e, s);
      Messages.alert("Erro ao buscar DADOS do fornecedor");
    }
  }

  @action
  Future<void> _findSupplierServices() async {
    try {
      _supplierServices = await _supplierService.findServices(_supplierId);
    } catch (e, s) {
      _log.error("Erro ao buscar SERVIÇOS do fornecedor", e, s);
      Messages.alert("Erro ao buscar SERVIÇOS do fornecedor");
    }
  }

  @action
  void addOrRemoveServices(SupplierServicesModel supplierServicesModel) {
    if (_servicesSelected.contains(supplierServicesModel)) {
      // se existir remove da lista
      _servicesSelected.remove(supplierServicesModel);
    } else {
      //se não existir add na lista
      _servicesSelected.add(supplierServicesModel);
    }
  }

  bool isServiceSelected(SupplierServicesModel servicesModel) =>
      _servicesSelected.contains(servicesModel);

  int get totalServicesSelected => _servicesSelected.length;

  Future<void> goToPhoneOrCopyPhoneToClipart() async {
    final phoneUrl = 'tel:${_supplierModel?.phone}';

    if (await canLaunchUrlString(phoneUrl)) {
      await launchUrlString(phoneUrl);
    } else {
      await Clipboard.setData(ClipboardData(text: _supplierModel?.phone ?? ''));
      Messages.info("Telefone Copiado!");
    }
  }

  Future<void> goToGeoOrCopyAddressToClipart() async {
    final geoUrl =
        'geo:${_supplierModel?.latitude},${_supplierModel?.latitude} ';
    if (await canLaunchUrlString(geoUrl)) {
      await launchUrlString(geoUrl);
    } else {
      await Clipboard.setData(
          ClipboardData(text: _supplierModel?.address ?? ''));
      Messages.info("Localização Copiada!");
    }
  }

  void goToSchedule() {
    Modular.to.pushNamed(
      '/schedules/',
      arguments: SchedulesViewModel(
        supplierId: _supplierId,
        services: _servicesSelected.toList(),
      ),
    );
  }
}
