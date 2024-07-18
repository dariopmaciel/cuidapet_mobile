// import 'package:flutter/material.dart';

part of '../address_page.dart';

class _AddressItem extends StatelessWidget {
  const _AddressItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      margin: const EdgeInsets.fromLTRB(0,0,10,0),
      child: const ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 30,
          child: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        ),
        title: Text("Av. Paulista, 200"),
        subtitle: Text("Complemento XX"),
      ),
    );
  }
}
