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
        Observer(
          builder: (_) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              child: homeController.supplierPageTypeSelected ==
                      SupplierPageType.list
                  ? const _HomeSuppplierList()
                  : const _HomeSupplierGrid(),
            );
          },
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
    return const Text('SupplierList');
  }
}

class _HomeSupplierGrid extends StatelessWidget {
  const _HomeSupplierGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("SupplierGrid");
  }
}
