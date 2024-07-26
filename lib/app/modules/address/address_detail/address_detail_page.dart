import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:flutter/material.dart';

class AddressDetailPage extends StatefulWidget {
  final PlaceModel place;

  const AddressDetailPage({super.key, required this.place});

  @override
  State<AddressDetailPage> createState() => _AddressDetailPageState();
}

class _AddressDetailPageState extends State<AddressDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe do endereço:'),
      ),
      body: Center(child: Text(widget.place.address),),
    );
  }
}
