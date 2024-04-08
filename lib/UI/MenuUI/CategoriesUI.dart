import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Models/MenuModels/MenuCollectionsResponseModel.dart';
import 'package:layla_app_dev/Services/ShopifyServices/Queries/getProductsByCollection.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/UI/CustomerServicesUI/ourLocationsUI.dart';
import 'package:layla_app_dev/UI/HelpUI/helpUI.dart';
import 'package:layla_app_dev/Utils/Constants/RouteConstants.dart';
import 'package:layla_app_dev/Utils/Globals.dart';

class CategoriesUI extends StatefulWidget {
  final MenuCollectionsResponseModel? collections;

  const CategoriesUI({super.key, this.collections});

  @override
  State<CategoriesUI> createState() => _CategoriesUIState();
}

class _CategoriesUIState extends State<CategoriesUI> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ListView.builder(
        itemCount: widget.collections?.menu?.items?.length,
        itemBuilder: (context, index) {
          var collectionItem = widget.collections?.menu?.items?[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 4.sp),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    if (collectionItem!.subCollectionItems!.isNotEmpty) {
                      Navigator.pushNamed(context, RouteConstants.subCategories,
                          arguments: {
                            'title': collectionItem.title,
                            'items': collectionItem.subCollectionItems,
                            'handle': collectionItem.url
                          });
                    } else {
                      Navigator.pushNamed(context, RouteConstants.products,
                          arguments: {
                            "handle": collectionItem.url,
                            'title': collectionItem.title,
                          });
                    }
                  },
                  child: Container(
                    width: size.width,
                    height: 65.sp,
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    decoration: BoxDecoration(
                        color: ColorConstants.dullWhite,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.5,
                            child: Text(
                              collectionItem?.title ?? "",
                              style: TextStyle(
                                  fontSize: FontSizes.normalText1,
                                  color: ColorConstants.textColorGrey
                                      .withOpacity(0.8),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          collectionItem?.subCollectionItems != null &&
                                  collectionItem!.subCollectionItems!.isNotEmpty
                              ? Icon(
                                  CupertinoIcons.forward,
                                  size: 20.sp,
                                  color: ColorConstants.textColorGrey
                                      .withOpacity(0.5),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
                index == widget.collections!.menu!.items!.length - 1
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.sp),
                            child: Divider(
                              color: ColorConstants.textColorGrey
                                  .withOpacity(0.25),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return HelpUI();
                              }));
                            },
                            child: Container(
                              width: size.width,
                              height: 35.sp,
                              padding: EdgeInsets.symmetric(horizontal: 18.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.question_circle,
                                          size: 20.sp,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        SizedBox(
                                          width: size.width * 0.5,
                                          child: Text(
                                            "Help",
                                            style: TextStyle(
                                                fontSize: FontSizes.smallText,
                                                color: ColorConstants
                                                    .textColorGrey
                                                    .withOpacity(0.8),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      CupertinoIcons.forward,
                                      size: 20.sp,
                                      color: ColorConstants.textColorGrey
                                          .withOpacity(0.5),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return OurLocationsUI();
                              }));
                            },
                            child: Container(
                              width: size.width,
                              height: 35.sp,
                              padding: EdgeInsets.symmetric(horizontal: 18.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.map_pin_ellipse,
                                          size: 20.sp,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        SizedBox(
                                          width: size.width * 0.5,
                                          child: Text(
                                            "Locations",
                                            style: TextStyle(
                                                fontSize: FontSizes.smallText,
                                                color: ColorConstants
                                                    .textColorGrey
                                                    .withOpacity(0.8),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      CupertinoIcons.forward,
                                      size: 20.sp,
                                      color: ColorConstants.textColorGrey
                                          .withOpacity(0.5),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.sp,
                          )
                        ],
                      )
                    : SizedBox()
              ],
            ),
          );
        });
  }
}
