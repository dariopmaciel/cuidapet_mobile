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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        shape: const StadiumBorder(),
        onPressed: () {},
        label: const Text(
          "Fazer Agendamento",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.schedule,
          color: Colors.white,
        ),
        backgroundColor: context.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            title: const Text("Clinica Central ABC",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center),
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
