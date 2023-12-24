import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Components/CustomSectionsWithSaleOption/ProductCard.dart';
import 'package:layla_app_dev/Controllers/FilteringController/filteringController.dart';
import 'package:layla_app_dev/Controllers/SortingController/sortingController.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/UI/ProductUI/FilteringUI/filteringUI.dart';
import 'package:layla_app_dev/UI/ProductUI/SortingUI/sortingUI.dart';
import 'package:layla_app_dev/UI/ProductUI/productDetail.dart';
import 'package:layla_app_dev/Utils/HelperFunctions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../Models/ProductModels/ProductByCollectionModel.dart';

class ProductsView extends StatefulWidget {
  final Products? products;
  final Future<dynamic> Function()? handleRefresh;

  const ProductsView({super.key, this.products, this.handleRefresh});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<FilteringController>(context, listen: false).initializeFilters(widget.products!);
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("did change dependencies called");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer2<FilteringController, SortingController>(builder: (context, filteringProvider, sortingProvider, child) {
        return Column(
          children: [
            Table(
              border: TableBorder.all(color: ColorConstants.textColorGrey.withOpacity(0.3)),
              children: [
                TableRow(children: [
                  InkWell(
                    onTap: () {
                      showBarModalBottomSheet(
                        context: context,
                        builder: (context) => const FilteringUI(),
                      ).then((value){
                        if(filteringProvider.filters.isNotEmpty){
                          widget.handleRefresh!();
                        }
                      });
                    },
                    child: SizedBox(
                      height: 35.sp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.slider_horizontal_3,
                            size: 20.sp,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(
                            "Filter",
                            style: TextStyle(fontSize: FontSizes.normalText1, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showBarModalBottomSheet(
                        context: context,
                        isDismissible: false,
                        builder: (context) => const SortingUI(),
                      ).then((value){
                        if(value){
                          sortingProvider.setSorting(widget.products?.edges);
                        }
                      });
                    },
                    child: SizedBox(
                      height: 35.sp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.arrow_up_arrow_down,
                            size: 15.sp,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(
                            "Sort",
                            style: TextStyle(fontSize: FontSizes.normalText1, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ])
              ],
            ),
            SizedBox(
              height: 10.sp,
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: GridView.builder(
                    padding: EdgeInsets.zero,
                  itemCount: widget.products?.edges?.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 375.sp,
                  ),
                  itemBuilder: (context, index) {
                    var productData = widget.products?.edges?[index];
                    var priceData = productData?.node?.priceRange?.minVariantPrice;
                    var discountedPrice = productData?.node?.compareAtPriceRange?.minVariantPrice;
                    return InkWell(
                      onTap: () {
                        print("ID:: ${productData?.node?.id}");
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => ProductDetail(productId: productData!.node!.id!)));
                      },
                      child: ProductCard(
                          width: size.width,
                        height: 280.sp,
                        productId: productData?.node?.id,
                        images: getProductImages(productData?.node?.images?.edges),
                        itemName: productData?.node?.title,
                        description: productData?.node?.description,
                        price: "${double.parse(priceData!.amount!).toStringAsFixed(3)} ${priceData.currencyCode}",
                        isOnSale: discountedPrice?.amount != "0.0" ? true : false,
                        discountedPrice: "${double.parse(discountedPrice!.amount!).toStringAsFixed(3)} ${priceData.currencyCode}",
                        savedPercent: discountedPrice?.amount != "0.0"
                            ? HelperFunctions()
                                .calculateDiscount(double.parse(discountedPrice.amount!), double.parse(priceData.amount!))
                            : "",
                      ),
                      );
                    }),
              ),
            ),
          ],
        );
      }
    );
  }

  List<String> getProductImages(List<ImageEdges>? images) {
    List<String> imagesUrl = [];
    images?.forEach((element) {
      imagesUrl.add(element.node!.originalSrc!);
    });

    return imagesUrl;
  }
}
