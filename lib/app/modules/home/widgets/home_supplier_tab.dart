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
        const AnimatedSwitcher(
            duration: Duration(milliseconds: 400), child: _HomeSuppplierList()),
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
              child: const Icon(Icons.view_headline)),
          InkWell(
              onTap: () =>
                  homeController.changeTabSupplier(SupplierPageType.grid),
              child: const Icon(Icons.view_comfy_alt)),
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
