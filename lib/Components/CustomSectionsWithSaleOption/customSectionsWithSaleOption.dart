import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:shopify_flutter/models/src/product/product.dart';
import 'package:shopify_flutter/models/src/product/shopify_image/shopify_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../UI/ProductUI/productDetail.dart';
import '../../Utils/HelperFunctions.dart';
import '../../Widgets/Buttons/favoriteButton.dart';
import '../../Widgets/CustomCarouselSlider/customCarouselSlider.dart';
import '../../Widgets/Images/AppLogo.dart';
import '../../Widgets/Images/NetworkImage.dart';

class CustomSectionsWithSaleOption extends StatefulWidget {
  final String? title;
  final List<Product>? itemsList;

  const CustomSectionsWithSaleOption({super.key, this.title, this.itemsList});

  @override
  State<CustomSectionsWithSaleOption> createState() => _CustomSectionsWithSaleOptionState();
}

class _CustomSectionsWithSaleOptionState extends State<CustomSectionsWithSaleOption> {

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.sp),
      child: Column(
        children: [
          Text(
            widget.title?.toUpperCase() ?? "",
            style: TextStyle(fontSize: FontSizes.normalText2, fontWeight: FontWeight.w500, color: ColorConstants.textColorGrey),
          ),
          SizedBox(
            height: 255.sp,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.itemsList?.length ?? 0,
                itemBuilder: (_, index) {
                  var productDetailData = widget.itemsList?[index];
                  var price = "${productDetailData?.currencyCode} ${productDetailData?.price.toString()}";
                  var discountedPrice = productDetailData!.hasComparablePrice
                      ? "${productDetailData.currencyCode} ${productDetailData.compareAtPrice.toString()}": "";
                  var savedPercent = productDetailData.hasComparablePrice
                      ? HelperFunctions().calculateDiscount(productDetailData.compareAtPrice, productDetailData.price): "";
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductDetail(productId: productDetailData.id)));
                    },
                    child: itemCard(productDetailData.id, productDetailData.title, price, getProductImages(productDetailData.images),
                        isOnSale: productDetailData.hasComparablePrice ? true : false,
                    discountedPrice: discountedPrice, savedPercent: savedPercent ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget itemCard(String productId, String itemName, String price, List<String> images, {bool isOnSale = false, String? discountedPrice,
    String? savedPercent}) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                width: 135.w,
                height: 197.sp,
                color: ColorConstants.secondaryColor,
                child: images.isNotEmpty
                    ? CustomCarousel(
                    height: 197.sp,
                    carouselController: carouselController,
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    autoPlayInterval: Duration(seconds: 1),
                    initialPage: currentIndex,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    carouselItems: List.generate(images.length,
                            (index) => appNetworkImage(images[index], double.infinity, double.infinity, BoxFit.fill)))
                    : SizedBox(
                  child: AppLogo(),
                ),
              ),
              images.isNotEmpty && images.length > 1
                  ? Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: SizedBox(
                  height: 30.sp,
                  child: AnimatedSmoothIndicator(
                      effect: ExpandingDotsEffect(
                          expansionFactor: 1.5.w,
                          dotWidth: 8.sp,
                          dotHeight: 8.sp,
                          spacing: 5.w,
                          dotColor: ColorConstants.textColorGrey.withOpacity(0.5),
                          activeDotColor: ColorConstants.primaryColor),
                      activeIndex: currentIndex,
                      count: images.length),
                ),
              )
                  : SizedBox(),
              Positioned(
                right: 0,
                child: SizedBox(
                  height: 197.sp,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FavoriteButton(
                          productId: productId,
                        ),
                        isOnSale
                            ? Container(
                              width: 40.w,
                              height: 25.sp,
                              decoration:
                              BoxDecoration(color: ColorConstants.primaryColor, borderRadius: BorderRadius.circular(10.r)),
                              child: Center(
                                child: Text(
                                  "${savedPercent}%",
                                  style: TextStyle(
                                      color: ColorConstants.secondaryColor,
                                      fontSize: FontSizes.extraSmallText,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            )
                            : SizedBox(
                          height: 10.sp,
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 10.sp,
          ),
          SizedBox(
            width: 127.w,
            child: Text(
              itemName,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w400, color: ColorConstants.textColorGrey),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isOnSale
                  ? Text(
                discountedPrice!,
                style: TextStyle(
                    fontSize: FontSizes.extraSmallText,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.textColorGrey.withOpacity(0.6),
                    decoration: TextDecoration.lineThrough
                ),
              )
                  : SizedBox(),
              SizedBox(
                width: isOnSale ? 3.w : 0,
              ),
              Text(
                price,
                style: TextStyle(
                    fontSize: FontSizes.smallText,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.textColorGrey),
              ),
            ],
          ),
        ],
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
