import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';

import 'package:flutter/material.dart';

class SupplierDetail extends StatelessWidget {
  const SupplierDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Center(
            child: Text("Clinica Central ABC",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),
        ),
        Divider(thickness: 1, color: context.primaryColor),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Informações do estabelecimento",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
        ),
        const ListTile(
          leading: Icon(
            Icons.location_city,
            color: Colors.black,
          ),
          title: Text("Avenida Paulista, 2000"),
        ),
        InkWell(
          onTap: () {},
          child: const ListTile(
            leading: InkWell(
              child: Icon(
                Icons.local_phone,
                color: Colors.black,
              ),
            ),
            title: Text("(11)98199-6400"),
          ),
        ),
        Divider(thickness: 1, color: context.primaryColor),
      ],
    );
  }
}
