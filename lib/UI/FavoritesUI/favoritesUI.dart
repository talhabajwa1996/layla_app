import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:shopify_flutter/models/src/product/product.dart';
import 'package:shopify_flutter/models/src/product/shopify_image/shopify_image.dart';

import '../../Components/CustomSectionsWithSaleOption/ProductCard.dart';
import '../../Utils/HelperFunctions.dart';
import '../ProductUI/productDetail.dart';

class FavoritesUI extends StatefulWidget {
  final List<Product>? productsList;

  const FavoritesUI({super.key, this.productsList});

  @override
  State<FavoritesUI> createState() => _FavoritesUIState();
}

class _FavoritesUIState extends State<FavoritesUI> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return widget.productsList!.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Love it? Add to favorites",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: FontSizes.largeText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Text(
                  "Favorites allow you to keep track of all your favorite items and shopping activity, so you won't have to waste time "
                  "searching all over again for that item you loved on store the other day - it's all here in one place",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstants.textColorGrey.withOpacity(0.6),
                    fontSize: FontSizes.smallText,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        : SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.productsList?.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 318.sp),
                  itemBuilder: (context, index) {
                    var productData = widget.productsList?[index];
                    var discountedPrice = productData?.compareAtPrice;
                    return InkWell(
                      onTap: () {
                        print("ID:: ${productData.id}");
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetail(productId: productData.id)));
                      },
                      child: ProductCard(
                        width: size.width,
                        height: 218.sp,
                        productId: productData?.id,
                        images: getProductImages(productData?.images),
                        itemName: productData?.title,
                        description: productData?.description,
                        price: "${productData?.price.toStringAsFixed(3)} ${productData?.currencyCode}",
                        isOnSale: productData!.hasComparablePrice ? true : false,
                        discountedPrice: "${discountedPrice?.toStringAsFixed(3)} ${productData.currencyCode}",
                        savedPercent: productData.hasComparablePrice
                            ? HelperFunctions().calculateDiscount(discountedPrice!, productData.price)
                            : "",
                      ),
                    );
                  }),
            ),
          );
  }

  List<String> getProductImages(List<ShopifyImage>? images) {
    List<String> imagesUrl = [];
    images?.forEach((element) {
      imagesUrl.add(element.originalSrc);
    });

    return imagesUrl;
  }
}
