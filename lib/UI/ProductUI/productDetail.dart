import 'package:flutter/material.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/UI/ProductUI/productDetailUI.dart';
import 'package:shopify_flutter/models/src/product/product.dart';

import '../../Widgets/Loaders/AppLoader.dart';

class ProductDetail extends StatefulWidget {
  final String productId;
  const ProductDetail({super.key, required this.productId});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  Future<List<Product>?>? getProductDetail;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductDetail = ShopifyService().shopifyStore.getProductsByIds([widget.productId]);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getProductDetail,
            builder: (context, AsyncSnapshot<List<Product>?> snapshot) {
              if (!snapshot.hasData) {
                return const AppLoader();
              } else {
                return ProductDetailUI(
                  productDetailDataInitial: snapshot.data?.first,
                );
              }
            }));
  }
}
