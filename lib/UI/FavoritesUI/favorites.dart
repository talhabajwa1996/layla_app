import 'package:flutter/material.dart';
import 'package:layla_app_dev/Controllers/FavoriteController/FavoriteController.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/UI/FavoritesUI/favoritesUI.dart';
import 'package:layla_app_dev/Widgets/Loaders/AppLoader.dart';
import 'package:provider/provider.dart';
import 'package:shopify_flutter/models/src/product/product.dart';

import '../../Widgets/CustomAppBar/LogoAppBar.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {

  Future<List<Product>?>? future;
  FavoriteController? favoriteController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favoriteController = Provider.of<FavoriteController>(context, listen: false);
    future = ShopifyService().shopifyStore.getProductsByIds(favoriteController!.favoriteItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: logoAppBar(
          showBackButton: true,
          onBackTap: () {
            Navigator.of(context).pop();
          }),
      body: FutureBuilder(
          future: future,
          builder: (context, AsyncSnapshot<List<Product>?> snapshot){
            if(!snapshot.hasData){
              return AppLoader();
            }else{
              var productsList = snapshot.data;
              return FavoritesUI(
                productsList: productsList
              );
            }
          }),
    );
  }
}
