import 'package:flutter/material.dart';
import 'package:layla_app_dev/Components/MenuCategories/MenuCategoryCard.dart';
import 'package:layla_app_dev/Utils/Constants/AppIcons.dart';
import 'package:layla_app_dev/Utils/Constants/ColorConstants.dart';
import '../../Models/MenuCollectionsModel/MenuCollectionsResponseModel.dart';

class MenuSubCategoriesUI extends StatefulWidget {
  final Map<String, dynamic> args;

  const MenuSubCategoriesUI(this.args, {super.key});

  @override
  State<MenuSubCategoriesUI> createState() => _MenuSubCategoriesUIState();
}

class _MenuSubCategoriesUIState extends State<MenuSubCategoriesUI> {
  List<SubCollectionItems>? items;
  String? title;

  @override
  void initState() {
    items = widget.args['items'];
    title = widget.args['title'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: ColorConstants.white,
            foregroundColor: ColorConstants.black,
            title: Text(
              title!.toUpperCase(),
              style: const TextStyle(
                  color: ColorConstants.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(AppIcons.search,
                      color: ColorConstants.primaryColor))
            ]),
        body: ListView.builder(
            itemCount: items!.length,
            itemBuilder: (context, index) =>
                MenuCategoryCard(title: items![index].title)));
  }
}
