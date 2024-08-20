import 'package:cuidapet_mobile/app/core/helpers/text_formatter.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/supplier_services_model.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';
import 'package:flutter/material.dart';

class SupplierServiceWidget extends StatelessWidget {
  final SupplierServicesModel service;
  final SupplierController supplierController;

  const SupplierServiceWidget(
      {super.key, required this.service, required this.supplierController});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // title: const Text("BANHO"),
      title: Text(service.name),
      // subtitle: const Text(r"R$ 10,00"),
      // subtitle:  Text("${service.price.toStringAsFixed(2)}"),
      subtitle: Text(
        TextFormatter.formatReal(service.price),
      ),
      leading: CircleAvatar(
        backgroundColor: context.primaryColor,
        child: const Icon(
          Icons.pets,
          color: Colors.black,
        ),
      ),
      // trailing: Icon(Icons.add_circle, color: context.primaryColor, size: 30),
      // trailing: const Icon(Icons.remove_circle, color: Colors.red, size:30),
      trailing: IconButton(
        onPressed: () {
          supplierController.addOrRemoveServices(service);
        },
        icon: supplierController.isServiceSelected(service) ? 
        Icon(Icons.add_circle, color: context.primaryColor, size: 30)
        : 
        const Icon(Icons.remove_circle, color: Colors.red, size:30)
        ,
      ),
    );
  }
}
