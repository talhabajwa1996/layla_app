import 'package:flutter/material.dart';
import 'package:layla_app_dev/Components/MenuCategories/MenuCategoryCard.dart';
import 'package:layla_app_dev/Widgets/Appbars/SearchAppBar.dart';
import '../../Models/MenuCollectionsModel/MenuCollectionsResponseModel.dart';

class MenuSubCategoriesUI extends StatelessWidget {
  final List<SubCollectionItems> items;

  const MenuSubCategoriesUI(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchAppBar(),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) =>
              MenuCategoryCard(title: items[index].title)),
    );
  }
}
