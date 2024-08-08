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
                    ? const _HomeSuppplierList()
                    : const _HomeSupplierGrid(),
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
  const _HomeSuppplierList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(
          childCount: 10,
          (context, index) {
            return const _HomeSuppplierListItemWidget();
          },
        ))
      ],
    );
  }
}

class _HomeSupplierGrid extends StatelessWidget {
  const _HomeSupplierGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("SupplierGrid");
  }
}

class _HomeSuppplierListItemWidget extends StatelessWidget {
  const _HomeSuppplierListItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Clinica Central ABC",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 25.r),
                            const Text('1.34Km de distancia')
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
                image: const DecorationImage(
                  // image: AssetImage('assets/images/logo.png'),
                  image: NetworkImage('https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS_ovn1hkTKcT5UdQE6QCuSNKJAfQKhpx23bYpcz9v-axoOCNg7'),
                  fit: BoxFit.contain
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
