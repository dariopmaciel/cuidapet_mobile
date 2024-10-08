import 'dart:async';
// import 'package:cuidapet_mobile/app/core/database/sqlite_connection_factory.dart';
// import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/core/mixins/location_mixin.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/modules/address/address_controller.dart';
import 'package:cuidapet_mobile/app/modules/address/widgets/address_search_widget/address_search_controller.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

part 'widgets/address_item.dart';
part 'widgets/address_search_widget/address_search_widget.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key, required place});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

// class _AddressPageState extends State<AddressPage> {
class _AddressPageState
    extends PageLifeCycleState<AddressController, AddressPage>
    with LocationMixin {
// class _AddressPageState extends PageLifeCycleState<ControllerLifeCycle, AddressPage> { // não feito assim pois se extendeu mixin no AddressController

  final reactonDisposers = <ReactionDisposer>[];

  @override
  void initState() {
    super.initState();
    final reactionService =
        // reaction<Observable<bool>>((_) => controller.locationServiceInavailable,
        reaction<bool>((_) => controller.locationServiceInavailable,
            (locationServiceUnavailable) {
      // if (locationServiceUnavailable.value) {
      if (locationServiceUnavailable) {
        showDialogLocationServiceUnavailable();
      }
    });

    final reactionLocationPermission = reaction<LocationPermission?>(
        (_) => controller.locationPermition, (locationPermission) {
      if (locationPermission != null &&
          locationPermission == LocationPermission.denied) {
        showDialogLocationDenied(
          tryAgain: () => controller.myLocation(),
        );
      } else if (locationPermission != null &&
          locationPermission == LocationPermission.denied) {
        showDialogLocationDeniedForever();
      }
    });

    reactonDisposers.addAll({reactionService, reactionLocationPermission});
  }

  @override
  void dispose() {
    for (var reaction in reactonDisposers) {
      reaction();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //*teste de BD em AndroidStudio => AppInspector > > CUIDAPE_LOCAL_API > address
    //* Modular.get<SqliteConnectionFactory>().openConnection();

    return PopScope(
      canPop: false,
      //  key:,
      // onPopInvoked: (_)=> controller.addressWasSelected(),
      onPopInvokedWithResult: (didPop, result) => controller.addressWasSelected(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ADICIONE ENDEREÇO',
            style: TextStyle(
              color: Colors.black,
              // color: Colors.white,
              fontSize: 18,
            ),
          ),
          iconTheme: IconThemeData(color: context.primaryColorDark),
          backgroundColor: Colors.white,
          // backgroundColor: context.primaryColor,
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
                const SizedBox(height: 5),
                //!---------------------------
                Observer(
                  builder: (_) {
                    //precisa recontruir novamente o widget, mas não chama o initstate
                    return _AddressSearchWidget(
                      //quando add 'key' ao componente (super.key) cria-se a possibilidade de se ter uma 'key: UniqueKey()' onde habilita a necessidade de sempre se reconstroi objeto a tela quando invocado
                      key: UniqueKey(),
                      addressSelectedCallBack: (place) {
                        // Modular.to.pushNamed('/address/detail/', arguments: place);
                        controller.goToAddressDetail(place);
                      },
                      place: controller.placemodel,
                    );
                  },
                ),
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
                const SizedBox(height: 20),
                ListTile(
                  onTap: () => controller.myLocation(),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 30,
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text(
                    "Localização atual",
                    style: TextStyle(fontSize: 18),
                  ),
                  // trailing: const Icon(Icons.arrow_forward_ios),
                ),
                const SizedBox(height: 20),
                Observer(
                  builder: (_) {
                    return Column(
                      children: controller.address.reversed
                          .map(
                            (a) => _AddressItem(
                              address: a.address,
                              additional: a.additional,
                              onTap: () {
                                controller.selectAddress(a);
                              },
                            ),
                          )
                          .toList(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
