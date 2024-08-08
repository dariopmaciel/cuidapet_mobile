import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:cuidapet_mobile/app/modules/home/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

part 'widgets/home_address_widget.dart';
part 'widgets/home_categories_widget.dart';
part 'widgets/home_supplier_tab.dart';

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
      drawer: const Drawer(),
      backgroundColor: Colors.grey[100],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          //item sem scroll vertical, rolagem pequena
          return <Widget>[
            HomeAppBar(controller),
            SliverToBoxAdapter(
                child: _HomeAddressWidget(controller: controller)),
             SliverToBoxAdapter(
              child: _HomeCategoriesWidget(controller),
            )
          ];
        },
        body: Container(),
      ),
    );
  }
}
/*
// mainAxisAlignment: MainAxisAlignment.center,
          // children: [
          //   TextButton(
          //     onPressed: () {
          //       FirebaseAuth.instance.signOut();
          //     },
          //     child: const Text('Logout'),
          //   ),
          //   TextButton(
          //     onPressed: () async {
          //       // final categoriesResponse = await Modular.get<RestClient>().auth().get('/categories/');
          //       // debugPrint(categoriesResponse.data);
          //       Navigator.pushNamed(context, '/address/');
          //     },
          //     child: const Text('Teste de Refresh Token'),
          //   ),
          //   //!----------
          //   TextButton(
          //     onPressed: () async {
          //       // await Modular.to.pushNamed('/address/');
          //       controller.goToAddressPage();
          //     },
          //     child: const Text('Ir para endereço'),
          //   ),
          //   //!----------
          //   TextButton(
          //     onPressed: () async {
          //       final address = await Modular.get<AddressService>().getAddressSelected();
          //       setState(() {
          //         addressEntity = address;
          //       });
          //     },
          //     child: const Text('Buscar endereço'),
          //   ),
          //   Observer(
          //       builder: (_) {
          //           return Text(controller.addressEntity?.address ?? "Nenhum Endereço Selecionado");
          //       },
          //   ),
          //   Observer(
          //       builder: (_) {
          //           return Text(controller.addressEntity?.additional ?? "Nenhum Complemento Selecionado");
          //       },
          //   )
          // ],

 */