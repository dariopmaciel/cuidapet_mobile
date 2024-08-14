// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../home_page.dart';

class _HomeSupplierTab extends StatelessWidget {
  final HomeController homeController;

  const _HomeSupplierTab(
    HomeController controller, {
    required this.homeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HomeTabHeader(homeController: homeController),
        Expanded(
          child: Observer(
            builder: (_) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: homeController.supplierPageTypeSelected ==
                        SupplierPageType.list
                    ? _HomeSuppplierList(homeController)
                    : _HomeSupplierGrid(homeController),
              );
            },
          ),
        )
      ],
    );
  }
}

class _HomeTabHeader extends StatelessWidget {
  final HomeController homeController;

  const _HomeTabHeader({required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          const Text("Estabelecimentos:"),
          const Spacer(),
          InkWell(
              onTap: () =>
                  homeController.changeTabSupplier(SupplierPageType.list),
              child: Observer(
                builder: (_) {
                  return Icon(
                    Icons.view_headline,
                    color: homeController.supplierPageTypeSelected ==
                            SupplierPageType.list
                        ? Colors.black
                        : Colors.grey,
                  );
                },
              )),
          const SizedBox(width: 10),
          InkWell(
              onTap: () =>
                  homeController.changeTabSupplier(SupplierPageType.grid),
              child: Observer(
                builder: (_) {
                  return Icon(
                    Icons.view_comfy_alt,
                    color: homeController.supplierPageTypeSelected ==
                            SupplierPageType.grid
                        ? Colors.black
                        : Colors.grey,
                  );
                },
              )),
        ],
      ),
    );
  }
}

class _HomeSuppplierList extends StatelessWidget {
  final HomeController _homeController;

  const _HomeSuppplierList(this._homeController);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Observer(
          builder: (_) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: _homeController.listSuppliersByAddress.length,
                (context, index) {
                  final supplier =
                      _homeController.listSuppliersByAddress[index];
                  return _HomeSuppplierListItemWidget(
                    supplier: supplier,
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}

class _HomeSuppplierListItemWidget extends StatelessWidget {
  final SupplierNearbyMeModel supplier;

  const _HomeSuppplierListItemWidget({required this.supplier});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed('/supplier/', arguments: supplier.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30),
              width: 1.sw,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      // alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 50),
                      // color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                                // "Clinica Central ABC",
                                supplier.name,
                                overflow: TextOverflow.ellipsis),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 25.r),
                              // const Text('1.34Km de distancia')
                              Text(
                                  '${supplier.distance.toStringAsFixed(2)} km de distancia.'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundColor: context.primaryColor,
                      maxRadius: 15,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  // color: Colors.red,
                  border: Border.all(
                    width: 1,
                    color: Colors.transparent,
                    // color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(100)),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[100]!,
                    width: 5,
                  ),
                  color: Colors.white,
                  // color: Colors.pink,
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    // image: AssetImage('assets/images/logo.png'),
                    // image: NetworkImage(
                    //     'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS_ovn1hkTKcT5UdQE6QCuSNKJAfQKhpx23bYpcz9v-axoOCNg7'),
                    image: NetworkImage(supplier.logo),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeSupplierGrid extends StatelessWidget {
  final HomeController controller;

  const _HomeSupplierGrid(this.controller);

  @override
  Widget build(BuildContext context) {
    // return const Text("SupplierGrid");
    return CustomScrollView(
      slivers: [
        Observer(
          builder: (_) {
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                childCount: controller.listSuppliersByAddress.length,
                (context, index) {
                  final supplier = controller.listSuppliersByAddress[index];
                  return _HomeSupplierCardItemWidget(supplier);
                },
              ),
              gridDelegate: //QTD de COLUNAS
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                // crossAxisSpacing: 1,
                // mainAxisSpacing: 1
              ),
            );
          },
        )
      ],
    );
  }
}

class _HomeSupplierCardItemWidget extends StatelessWidget {
  final SupplierNearbyMeModel supplier;

  const _HomeSupplierCardItemWidget(this.supplier);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed('/supplier/', arguments: supplier.id);
      },
      child: Stack(
        children: [
          Card(
            margin:
                const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.grey[200],
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 10, right: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      // 'Clinica Central ABC',
                      supplier.name,
                      style: context.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      // '1,34 Km de distância',
                      '${supplier.distance.toStringAsFixed(2)} Km de distância',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[100],
            ),
          ),
          Positioned(
            top: 4,
            left: 0,
            right: 0,
            child: Center(
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                    // 'https://conteudo.imguol.com.br/c/entretenimento/eb/2022/03/23/cachorro-da-raca-lulu-da-pomeramia-1648065976007_v2_900x506.jpg',
                    supplier.logo),
              ),
            ),
          )
        ],
      ),
    );
  }
}
