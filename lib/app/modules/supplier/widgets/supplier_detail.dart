// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/supplier_model.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';

class SupplierDetail extends StatelessWidget {
  final SupplierModel supplier;

final SupplierController controller;


  const SupplierDetail({
    Key? key,
    required this.supplier,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Center(
            // child: Text("Clinica Central ABC",
            child: Text(supplier.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),
        ),
        Divider(thickness: 1, color: context.primaryColor),
        const Padding(
          padding: EdgeInsets.all(8.0),
          // child: Text("Informações do estabelecimento",
          child: Text("Informações do estabelecimento",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
        ),
        ListTile(
          onTap: () => controller.goToGeoOrCopyAddressToClipart(),
          leading: const Icon(Icons.location_city, color: Colors.black),
          // title: Text("Avenida Paulista, 2000"),
          title: Text(supplier.address),
        ),
        ListTile(
          onTap: () => controller.goToPhoneOrCopyPhoneToClipart(),
          leading: const InkWell(
            child: Icon(
              Icons.local_phone,
              color: Colors.black,
            ),
          ),
          // title: Text("(11)98199-6400"),
          title: Text(supplier.phone),
        ),
        Divider(thickness: 1, color: context.primaryColor),
      ],
    );
  }
}
