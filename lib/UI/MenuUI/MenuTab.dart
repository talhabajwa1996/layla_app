import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Models/MenuModels/MenuCollectionsResponseModel.dart';
import 'package:layla_app_dev/UI/MenuUI/CategoriesUI.dart';
import 'package:shopify_flutter/enums/src/sort_key_collection.dart';
import 'package:shopify_flutter/models/src/collection/collection.dart';

import '../../Services/ShopifyServices/Queries/collectionAndSubCollection.dart';
import '../../Services/ShopifyServices/ShopifyServices.dart';
import '../../Widgets/Loaders/AppLoader.dart';

class MenuTab extends StatefulWidget {
  const MenuTab({super.key});

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  Future<Map<String, dynamic>?>? getAllCollections;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCollections = ShopifyService().shopifyCustom.customQuery(gqlQuery: menuCollectionsAndSubCollectionsQuery);
  }

  Future<void> _handleRefresh() async {
    getAllCollections = ShopifyService().shopifyCustom.customQuery(gqlQuery: menuCollectionsAndSubCollectionsQuery);

    await Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: FutureBuilder(
          future: getAllCollections,
          builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
            if (!snapshot.hasData) {
              return const AppLoader();
            } else {
              MenuCollectionsResponseModel responseModel = MenuCollectionsResponseModel.fromJson(snapshot.data!);
              return CategoriesUI(
                collections: responseModel,
              );
            }
          }),
    );
  }
}
