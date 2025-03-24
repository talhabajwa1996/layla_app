import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Widgets/Buttons/favoriteButton.dart';
import 'package:layla_app_dev/Widgets/CustomCarouselSlider/customCarouselSlider.dart';
import 'package:layla_app_dev/Widgets/Images/AppLogo.dart';
import 'package:layla_app_dev/Widgets/Images/NetworkImage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../AppTheme/fontSizes.dart';

class ProductCard extends StatefulWidget {
  final double? width;
  final double? height;
  final String? productId;
  final List<String>? images;
  final String? itemName;
  final String? description;
  final String? price;
  final bool isOnSale;
  final String? discountedPrice;
  final String? savedPercent;

  ProductCard(
      {super.key,
      this.itemName,
      this.price,
      this.isOnSale = false,
      this.discountedPrice,
      this.width,
      this.height,
      this.images,
      this.description, this.savedPercent, this.productId});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final CarouselSliderController carouselController = CarouselSliderController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                width: widget.width ?? 135.w,
                height: widget.height ?? 197.sp,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.r),
                  color: ColorConstants.secondaryColor.withOpacity(0.3),
                ),
                alignment: Alignment.center,
                child: widget.images != null && widget.images!.isNotEmpty
                    ? CustomCarousel(
                        height: widget.height ?? 197.sp,
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
                        carouselItems: List.generate(widget.images!.length,
                            (index) => appNetworkImage(widget.images?[index], double.infinity, double.infinity, BoxFit.fill)))
                    : SizedBox(
                  child: AppLogo(),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: widget.height,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FavoriteButton(
                          productId: widget.productId,
                        ),
                        widget.isOnSale
                            ? Container(
                                width: 40.w,
                                height: 25.sp,
                                decoration:
                                    BoxDecoration(color: ColorConstants.primaryColor, borderRadius: BorderRadius.circular(10.r)),
                                child: Center(
                                  child: Text(
                                   "${ widget.savedPercent ?? ""}%",
                                    style: TextStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.extraSmallText,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 10.sp,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              widget.images!.isNotEmpty && widget.images!.length > 1
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
                            count: widget.images?.length ?? 0),
                      ),
                    )
                  : SizedBox()
            ],
          ),
          SizedBox(
            height: 10.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Wrap(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.itemName!,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w600, color: ColorConstants.textColorGrey),
                  ),
                ),
                widget.description != null ? SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.description!,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: FontSizes.extraSmallText, fontWeight: FontWeight.w400, color: ColorConstants.textColorGrey),
                  ),
                ) : SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.isOnSale
                        ? Text(
                      widget.discountedPrice!,
                      style: TextStyle(
                        fontSize: FontSizes.extraSmallText,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.textColorGrey.withOpacity(0.6),
                          decoration: TextDecoration.lineThrough
                      ),
                    )
                        : SizedBox(),
                    SizedBox(
                      width: widget.isOnSale ? 3.w : 0,
                    ),
                    Text(
                      widget.price!,
                      style: TextStyle(
                          fontSize: FontSizes.smallText,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.textColorGrey),
                    ),


                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
