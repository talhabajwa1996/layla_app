import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Components/CustomSectionsWithSaleOption/customSectionsWithSaleOption.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/Utils/HelperFunctions.dart';
import 'package:layla_app_dev/Widgets/Buttons/CustomFilledButton.dart';
import 'package:layla_app_dev/Widgets/Buttons/customBackButton.dart';
import 'package:layla_app_dev/Widgets/Buttons/favoriteButton.dart';
import 'package:layla_app_dev/Widgets/CustomCarouselSlider/customCarouselSlider.dart';
import 'package:layla_app_dev/Widgets/Images/AppLogo.dart';
import 'package:layla_app_dev/Widgets/Loaders/AppLoader.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../Widgets/Buttons/CustomElevatedButton.dart';
import '../../Widgets/Images/NetworkImage.dart';

class ProductDetailUI extends StatefulWidget {
  final Product? productDetailData;

  const ProductDetailUI({super.key, this.productDetailData});

  @override
  State<ProductDetailUI> createState() => _ProductDetailUIState();
}

class _ProductDetailUIState extends State<ProductDetailUI> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  String productSize = "";
  String productColor = "";
  Future<List<Product>?>? future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.productDetailData?.toJson());

    var (a, b) = getFirstAvailableOption();
    productSize = a;
    productColor = b;
    print("Size / Color:: $productSize / $productColor");

    future = ShopifyService().shopifyStore.getProductRecommendations(widget.productDetailData!.id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          ListView(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CustomCarousel(
                      height: size.height * 0.6,
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
                      carouselItems: widget.productDetailData!.images.isNotEmpty
                          ? List.generate(widget.productDetailData!.images.length, (index) {
                              var shopifyProductImage = widget.productDetailData!.images;
                              return appNetworkImage(
                                  shopifyProductImage[index].originalSrc, size.width, double.infinity, BoxFit.contain);
                            })
                          : [
                              const SizedBox(
                                child: AppLogo(),
                              )
                            ]),
                  widget.productDetailData!.images.isNotEmpty && widget.productDetailData!.images.length > 1
                      ? SizedBox(
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
                              count: widget.productDetailData!.images.length),
                        )
                      : SizedBox()
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productDetailData!.title,
                      style: TextStyle(fontSize: FontSizes.normalText1, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "SKU : ${widget.productDetailData!.productVariants.first.sku}",
                      style: TextStyle(
                          fontSize: FontSizes.smallText,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.textColorGrey.withOpacity(0.6)),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(
                      widget.productDetailData!.description ?? "",
                      style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widget.productDetailData!.hasComparablePrice
                            ? Text(
                                "${widget.productDetailData!.currencyCode} ${widget.productDetailData!.compareAtPrice.toString()}",
                                style: TextStyle(
                                    fontSize: FontSizes.extraSmallText,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.textColorGrey,
                                    decoration: TextDecoration.lineThrough),
                              )
                            : SizedBox(),
                        SizedBox(
                          width: widget.productDetailData!.hasComparablePrice ? 3.w : 0,
                        ),
                        Text(
                          "${widget.productDetailData!.currencyCode} ${widget.productDetailData!.price.toString()}",
                          style: TextStyle(
                              fontSize: FontSizes.normalText1,
                              fontWeight: FontWeight.w600,
                              color: widget.productDetailData!.hasComparablePrice
                                  ? ColorConstants.primaryColor
                                  : ColorConstants.textColorGrey),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        widget.productDetailData!.hasComparablePrice
                            ? Text(
                                "( Saved ${HelperFunctions().calculateDiscount(widget.productDetailData!.compareAtPrice, widget.productDetailData!.price)}% )",
                                style: TextStyle(
                                  fontSize: FontSizes.extraSmallText,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.textColorGrey,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    _buildOptions(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.sp, horizontal: 30.w),
                      child: Divider(
                        color: ColorConstants.textColorGrey.withOpacity(0.3),
                      ),
                    ),
                    FutureBuilder(
                        future: future,
                        builder: (context, AsyncSnapshot<List<Product>?> snapshot) {
                          if (!snapshot.hasData) {
                            return AppLoader();
                          } else {
                            return CustomSectionsWithSaleOption(
                              title: "Recommended",
                              itemsList: snapshot.data,
                            );
                          }
                        }),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.sp, horizontal: 30.w),
                      child: Divider(
                        color: ColorConstants.textColorGrey.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.3,
              )
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomBackButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  FavoriteButton(
                    productId: widget.productDetailData?.id,
                    boxColor: ColorConstants.secondaryColor.withOpacity(0.5),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100.sp,
              width: size.width,
              color: ColorConstants.white,
              child: UnconstrainedBox(
                child: CustomFilledButton(
                  height: 35.sp,
                  width: size.width * 0.9,
                  title: checkProductAvailability(productSize, productColor) ? "Add to cart" : "Sold out",
                  btnColor:
                      checkProductAvailability(productSize, productColor) ? ColorConstants.primaryColor : ColorConstants.grey,
                  textColor: ColorConstants.white,
                  btnRadius: 5.r,
                  onPressed: () {},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildOptions() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.productDetailData!.option.length,
        itemBuilder: (context, firstIndex) {
          var option = widget.productDetailData!.option[firstIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                option.name,
                style: TextStyle(
                  fontSize: FontSizes.normalText1,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.textColorGrey,
                ),
              ),
              SizedBox(
                height: 3.sp,
              ),
              SizedBox(
                height: 38.sp,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: option.values.length,
                    itemBuilder: (context, secondIndex) {
                      bool isSizeAvailable = option.name.toLowerCase() == "size" &&
                          !checkSizeAvailability(
                              size: widget.productDetailData?.option
                                  .where((element) => element.name.toLowerCase() == "size")
                                  .first
                                  .values[secondIndex],
                              color: productColor);
                      bool isColorAvailable = option.name.toLowerCase() == "color" &&
                          !checkSizeAvailability(
                              size: productSize,
                              color: widget.productDetailData?.option
                                  .where((element) => element.name.toLowerCase() == "color")
                                  .first
                                  .values[secondIndex]);
                      return InkWell(
                        onTap: () {
                          if (isSizeAvailable || isColorAvailable) {
                            print("out of stock");
                          } else if (option.name.toLowerCase() == "size") {
                            setState(() {
                              productSize = option.values[secondIndex];
                            });
                          } else if (option.name.toLowerCase() == "color") {
                            setState(() {
                              productColor = option.values[secondIndex];
                            });
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            UnconstrainedBox(
                              child: Padding(
                                padding: EdgeInsets.only(right: 5.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.r),
                                      color: isSizeAvailable || isColorAvailable
                                          ? ColorConstants.dullWhite.withOpacity(0.5)
                                          : productSize == option.values[secondIndex] ||
                                                  productColor == option.values[secondIndex]
                                              ? ColorConstants.primaryColor
                                              : ColorConstants.white,
                                      border: isSizeAvailable || isColorAvailable
                                          ? Border()
                                          : Border.all(color: ColorConstants.textColorGrey.withOpacity(0.6)),
                                      boxShadow: isSizeAvailable || isColorAvailable
                                          ? []
                                          : [
                                              BoxShadow(
                                                  color: ColorConstants.textColorGrey.withOpacity(0.1),
                                                  spreadRadius: 2,
                                                  blurRadius: 1)
                                            ]),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.sp),
                                    child: Center(
                                      child: Text(
                                        option.values[secondIndex],
                                        style: TextStyle(
                                          fontSize: FontSizes.smallText,
                                          fontWeight: FontWeight.w400,
                                          color: productSize == option.values[secondIndex] ||
                                                  productColor == option.values[secondIndex]
                                              ? ColorConstants.white
                                              : ColorConstants.textColorGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            isSizeAvailable
                                ? Center(
                                    child: Icon(
                                      CupertinoIcons.clear,
                                      size: 30.sp,
                                      color: ColorConstants.textColorGrey.withOpacity(0.5),
                                    ),
                                  )
                                : SizedBox(),
                            isColorAvailable
                                ? Center(
                                    child: Icon(
                                      CupertinoIcons.clear,
                                      size: 30.sp,
                                      color: ColorConstants.textColorGrey.withOpacity(0.5),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 5.sp,
              ),
            ],
          );
        });
  }

  Future<Widget> _buildRecommendedSection() async {
    return Container(
      width: 360.w,
      height: 300.sp,
      child: FutureBuilder(
          future: future,
          builder: (context, AsyncSnapshot<List<Product>?> snapshot) {
            if (!snapshot.hasData) {
              return AppLoader();
            } else {
              return CustomSectionsWithSaleOption(
                title: "Recommended",
                itemsList: snapshot.data,
              );
            }
          }),
    );
  }

  checkProductAvailability([String? size, String? color]) {
    bool isAvailable = false;
    var productVariants = widget.productDetailData?.productVariants.toList();
    productVariants?.forEach((element) {
      if (element.title == "$size / $color" && element.availableForSale) {
        setState(() {
          isAvailable = true;
        });
      }
    });
    return isAvailable;
  }

  checkSizeAvailability({String? size, String? color}) {
    bool isAvailable = false;
    var productVariants = widget.productDetailData?.productVariants.toList();
    var variant =
        productVariants!.where((element) => element.title.split(" / ")[0] == size && element.title.split(" / ")[1] == color);
    if (variant.isNotEmpty) {
      isAvailable = variant.first.availableForSale;
      return isAvailable;
    }
    return isAvailable;
  }

  (String, String) getFirstAvailableOption() {
    String size = '';
    String color = '';
    var sizeOptions = widget.productDetailData!.option.where((element) => element.name.toLowerCase() == "size").first.values;
    var colorOptions = widget.productDetailData!.option.where((element) => element.name.toLowerCase() == "color").first.values;
    var productVariants = widget.productDetailData?.productVariants;
    for (var s in sizeOptions) {
      for (var c in colorOptions) {
        var check = productVariants!.where(
            (element) => (element.title.split(" / ")[0] == s && element.title.split(" / ")[1] == c) && element.availableForSale);
        if (check.isNotEmpty) {
          size = check.first.title.split(" / ")[0];
          color = check.first.title.split(" / ")[1];
          return (size, color);
        }
      }
    }
    return ("", "");
  }

// checkColorAvailability(String? color, {String }) {
//   bool isAvailable = false;
//   var productVariants = widget.productDetailData?.productVariants.toList();
//   isAvailable = productVariants!.where((element) => element.title.split(" / ")[1] == color).first.availableForSale;
//   return isAvailable;
// }
}
