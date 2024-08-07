part of '../home_page.dart';

class _HomeCategoriesWidget extends StatelessWidget {
  final HomeController _controller;
  const _HomeCategoriesWidget(this._controller);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 130,
        child: Observer(
          builder: (_) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _controller.listCategories.length,
              itemBuilder: (context, index) {
                final category = _controller.listCategories[index];
                return  _CategoryItem(category);
              },
            );
          },
        ));
  }
}

class _CategoryItem extends StatelessWidget {
  final SupplierCategoryModel _categoryModel;
  const _CategoryItem(this._categoryModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: context.primaryColorLight,
            radius: 30,
            child: const Icon(
              Icons.pets,
              size: 30,
              color: Colors.black,
            ),
          ),
           Text(_categoryModel.name),
        ],
      ),
    );
  }
}
