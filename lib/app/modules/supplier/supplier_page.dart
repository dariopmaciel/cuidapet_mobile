import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_detail.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_service_widget.dart';
import 'package:flutter/material.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({super.key});

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  late ScrollController _scrollController;
  bool sliverColapsed = false;
  final sliverColapsedVN = ValueNotifier(false);

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
  Widget build(BuildContext context) {
    print("BUILLLLDDDD!!!!!!!!!!!!!!!!!!!!");
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
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            title: ValueListenableBuilder<bool>(
              valueListenable: sliverColapsedVN,
              builder: (_, sliverColapsedValue, child) {
                print("BUILLLLDDOOOOOOOOOOOOOO!!!!!!!!!!!!!!!!!!!!");
                return Visibility(
                  visible: sliverColapsedValue,
                  child: const Text("Clinica Central ABC",
                      textAlign: TextAlign.center),
                );
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwyXeKDN29AmZgZPLS7n0Bepe8QmVappBwZCeA3XWEbWNdiDFB',
                fit: BoxFit.cover,
                //não tem imagem ou imagem está quebrada
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SupplierDetail(),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Serviços (0 selecionados)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 200,
            (context, index) {
              return const SupplierServiceWidget();
            },
          )),
        ],
      ),
    );
  }
}
