import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_detail.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SupplierPage extends StatefulWidget {
  final int _supplierId;

  const SupplierPage({
    super.key,
    required int supplierId,
  })  : _supplierId = supplierId;

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState
    extends PageLifeCycleState<SupplierController, SupplierPage> {
  late ScrollController _scrollController;
  bool sliverColapsed = false;
  final sliverColapsedVN = ValueNotifier(false);

  @override
  Map<String, dynamic>? get params => {'supplierId': widget._supplierId};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 180 &&
          !_scrollController.position.outOfRange) {
        sliverColapsedVN.value = true;
        // setState(() {
        //   sliverColapsed = true;
        // });
      } else if (_scrollController.offset <= 180 &&
          !_scrollController.position.outOfRange) {
        sliverColapsedVN.value = false;
        // setState(() {
        //   sliverColapsed = false;
        // });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("BUILLLLDDDD!!!!!!!!!!!!!!!!!!!!");
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          shape: const StadiumBorder(),
          onPressed: () {},
          label: const Text(
            "Fazer Agendamento",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          icon: const Icon(
            Icons.schedule,
            color: Colors.white,
          ),
          backgroundColor: context.primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Observer(
          builder: (_) {
            final supplier = controller.supplierModel;
            //para acionar: supplier?.name ?? '',
            // ou
            if (supplier == null) {
              return const Text("Buscando dados do fornecedor");
            }

            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  title: ValueListenableBuilder<bool>(
                    valueListenable: sliverColapsedVN,
                    builder: (_, sliverColapsedValue, child) {
                      // print("BUILLLLDDOOOOOOOOOOOOOO!!!!!!!!!!!!!!!!!!!! ");
                      return Visibility(
                        visible: sliverColapsedValue,
                        // child: const Text("Clinica Central ABC",
                        child: Text(supplier.name, textAlign: TextAlign.center),
                      );
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [
                      StretchMode.zoomBackground,
                      StretchMode.fadeTitle,
                    ],
                    background: Image.network(
                      // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwyXeKDN29AmZgZPLS7n0Bepe8QmVappBwZCeA3XWEbWNdiDFB',
                      supplier.logo,
                      fit: BoxFit.cover,
                      //não tem imagem ou imagem está quebrada
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.shrink(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SupplierDetail(supplier: supplier),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Serviços (0 selecionados)",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: controller.supplierServices.length,
                  (context, index) {
                    final service = controller.supplierServices[index];
                    return SupplierServiceWidget(service: service);
                  },
                )),
              ],
            );
          },
        ));
  }
}
