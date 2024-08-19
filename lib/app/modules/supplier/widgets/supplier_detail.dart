import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/supplier_model.dart';

import 'package:flutter/material.dart';

class SupplierDetail extends StatelessWidget {
  final SupplierModel supplier;

  const SupplierDetail({super.key, required this.supplier});

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
          leading: const Icon(Icons.location_city, color: Colors.black),
          // title: Text("Avenida Paulista, 2000"),
          title: Text(supplier.address),
        ),
        InkWell(
          onTap: () {},
          child:  ListTile(
            leading: const InkWell(
              child: Icon(
                Icons.local_phone,
                color: Colors.black,
              ),
            ),
            // title: Text("(11)98199-6400"),
            title: Text(supplier.phone),
          ),
        ),
        Divider(thickness: 1, color: context.primaryColor),
      ],
    );
  }
}
