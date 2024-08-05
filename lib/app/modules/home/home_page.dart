import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/entities/address_entity.dart';
// import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

AddressEntity? addressEntity;

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {
  AddressEntity? addressEntity;

  @override
  Map<String, dynamic>? get params => {'Teste': 'Teste life cycle'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text('Logout'),
            ),
            TextButton(
              onPressed: () async {
                // final categoriesResponse = await Modular.get<RestClient>().auth().get('/categories/');
                // debugPrint(categoriesResponse.data);
                Navigator.pushNamed(context, '/address/');
              },
              child: const Text('Teste de Refresh Token'),
            ),
            //!----------
            TextButton(
              onPressed: () async {
                await Modular.to.pushNamed('/address/');
              },
              child: const Text('Ir para endereço'),
            ),
            //!----------
            TextButton(
              onPressed: () async {
                final address = await Modular.get<AddressService>().getAddressSelected();
                setState(() {
                  addressEntity = address;
                });
              },
              child: const Text('Buscar endereço'),
            ),
            Text(addressEntity?.address ?? "Nenhum Endereço Selecionado"),
            Text(addressEntity?.additional ?? "Nenhum Complemento Selecionado"),
          ],
        ),
      ),
    );
  }
}
