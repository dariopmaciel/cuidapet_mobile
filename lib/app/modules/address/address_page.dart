import 'dart:async';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/modules/address/widgets/address_search_widget/address_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

part 'widgets/address_item.dart';
part 'widgets/address_search_widget/address_search_widget.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key, required place});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Defina endereço:',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(color: context.primaryColorDark),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
          child: Column(
            children: [
              // Text(
              //   'Adicione ou escolha um endereço:',
              //   style: context.textTheme.headlineLarge?.copyWith(
              //     color: Colors.black,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: 20),
              //!---------------------------
              _AddressSearchWidget(addressSelectedCallBack: (place) {
                print(place);
              }),
              //!---------------------------
              // Material(
              //   elevation: 10,
              //   borderRadius: BorderRadius.circular(0),
              //   color: Colors.white,
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //   ),
              // ),
              //!---------------------------
              SizedBox(height: 20),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 30,
                  child: Icon(
                    Icons.near_me,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Localização atual",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  AddressItem(),
                  AddressItem(),
                  AddressItem(),
                  AddressItem(),
                  AddressItem(),
                  AddressItem(),
                  AddressItem(),
                  AddressItem(),
                  AddressItem(),
                  AddressItem(),
                  AddressItem(),
                  AddressItem(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
