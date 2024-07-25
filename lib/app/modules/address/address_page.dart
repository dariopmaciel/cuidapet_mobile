import 'dart:async';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

part 'widgets/address_item.dart';
part 'widgets/address_search_widget/address_search_widget.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Defina endereço atual:',
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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
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
              _AddressSearchWidget(),
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
