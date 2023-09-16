import 'package:flutter/material.dart';
import 'package:layla_app_dev/Components/MenuCategories/MenuCategoryCard.dart';
import 'package:layla_app_dev/Controllers/MenuCollectionsController/MenuCollectionsController.dart';
import 'package:layla_app_dev/Utils/Constants/RouteConstants.dart';
import 'package:provider/provider.dart';

class MenuMainCategories extends StatelessWidget {
  const MenuMainCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuCollectionsController>(
        builder: (context, menuCollectionsController, child) =>
            ListView.builder(
                itemCount: menuCollectionsController
                    .menuCollectionsResponse!.menu!.items!.length,
                itemBuilder: (context, index) => MenuCategoryCard(
                    title: menuCollectionsController
                        .menuCollectionsResponse!.menu!.items![index].title,
                    onTap: () {
                      if (menuCollectionsController.menuCollectionsResponse!
                          .menu!.items![index].subCollectionItems!.isNotEmpty) {
                        Navigator.of(context).pushNamed(
                            RouteConstants.menuSubCategories,
                            arguments: menuCollectionsController
                                .menuCollectionsResponse!
                                .menu!
                                .items![index]
                                .subCollectionItems);
                      }
                    })));
  }
}
