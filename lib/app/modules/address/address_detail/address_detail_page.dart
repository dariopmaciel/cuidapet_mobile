import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
        // title: const Text('Detalhe do endereço:'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: context.primaryColorDark),
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      // Center(child: Text(widget.place.address)),
      body: Column(
        children: [
          Text(
            'Confirme seu endereço:',
            style: context.textTheme.headlineLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  widget.place.lat,
                  widget.place.lng,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
