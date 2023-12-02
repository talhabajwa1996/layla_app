import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Controllers/SearchBarController/searchBarController.dart';
import 'package:layla_app_dev/Widgets/Buttons/favoriteButton.dart';
import 'package:layla_app_dev/Widgets/Images/AppLogo.dart';
import 'package:layla_app_dev/Widgets/Images/NetworkImage.dart';
import 'package:layla_app_dev/Widgets/Loaders/AppLoader.dart';
import 'package:provider/provider.dart';
import 'package:shopify_flutter/enums/enums.dart';
import 'package:shopify_flutter/models/src/product/product.dart';

import '../../Services/ShopifyServices/ShopifyServices.dart';
import '../ProductUI/productDetail.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  Future<List<Product>>? future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // future = ShopifyService().shopifyStore.getAllProductsOnQuery(
    //     "",
    //     Provider.of<SearchBarController>(context, listen: false).searchController.text.isEmpty
    //         ? "??"
    //         : Provider.of<SearchBarController>(context, listen: false).searchController.text,
    //     sortKey: SortKeyProduct.BEST_SELLING);
  }

  // Future<void> _handleRefresh() async {
  //   future = ShopifyService().shopifyStore.getAllProductsOnQuery(
  //       "",  Provider.of<SearchBarController>(context, listen: false).searchController.text.isEmpty
  //       ? "??"
  //       : Provider.of<SearchBarController>(context, listen: false).searchController.text,
  //       sortKey: SortKeyProduct.BEST_SELLING);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<SearchBarController>(
        builder: (context, searchbarProvider, child) {
          if (searchbarProvider.isLoadingProducts) {
            return AppLoader();
          } else {
            return searchbarProvider.searchedProducts.isNotEmpty ? ListView.builder(
              itemCount: searchbarProvider.searchedProducts.length,
              itemBuilder: (context, index) {
                var productData = searchbarProvider.searchedProducts[index];
                return InkWell(
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => ProductDetail(productId: productData.id)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width,
                      height: 100.sp,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: ColorConstants.dullWhite, borderRadius: BorderRadius.circular(5.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          productData.images.isNotEmpty
                              ? appNetworkImage(productData.image, 75.w, double.infinity, BoxFit.contain)
                              : Container(
                                  width: 75.w,
                                  height: double.infinity,
                                  color: ColorConstants.secondaryColor.withOpacity(0.5),
                                  child: AppLogo(),
                                ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.sp),
                                child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Text(
                                  productData.title,
                                  style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  productData.description ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: FontSizes.extraSmallText, fontWeight: FontWeight.w400),
                                ),
                                Spacer(),
                                Text("${productData.currencyCode} ${productData.price.toString()}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600
                                ),)
                            ],
                          ),
                              )),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FavoriteButton(
                                  productId: productData.id,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
                : Center(child: Text("didn't find anything"));
          }
        });
  }
}
