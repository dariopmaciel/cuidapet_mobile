// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cuidapet_mobile/app/models/supplier_services_model.dart';

class SchedulesViewModel {
  final int supplierId;
  final List<SupplierServicesModel> services;

  SchedulesViewModel({
    required this.supplierId,
    required this.services,
  });
}
