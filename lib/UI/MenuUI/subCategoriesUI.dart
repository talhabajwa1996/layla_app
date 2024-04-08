import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Models/PageModel/aboutUsPageModel.dart';
import 'package:layla_app_dev/Services/ShopifyServices/Queries/getAboutUsPage.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/UI/CustomerServicesUI/contactUsUI.dart';
import 'package:layla_app_dev/UI/ExchangeAndReturnsUI/exchangeAndReturnUI.dart';
import 'package:layla_app_dev/UI/CustomerServicesUI/ourLocationsUI.dart';
import 'package:layla_app_dev/Widgets/Buttons/customBackButton.dart';
import 'package:layla_app_dev/Widgets/Images/AppLogo.dart';
import 'package:layla_app_dev/Widgets/Notifiers/Toast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopify_flutter/models/src/shop/shop.dart';
import '../../Models/MenuModels/MenuCollectionsResponseModel.dart';
import '../../Utils/Constants/RouteConstants.dart';
import '../CustomerServicesUI/faqsUI.dart';

class SubCategoriesUI extends StatefulWidget {
  final Map<String, dynamic>? args;

  const SubCategoriesUI({super.key, this.args});

  @override
  State<SubCategoriesUI> createState() => _SubCategoriesUIState();
}

class _SubCategoriesUIState extends State<SubCategoriesUI> {
  String? title;
  List<SubCollectionItems>? items;
  String? handle;

  @override
  void initState() {
    title = widget.args?['title'];
    items = widget.args?['items'];
    handle = widget.args?['handle'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.baseColor,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.only(left: 15.w, top: 8.sp, bottom: 8.sp),
            child: CustomBackButton(
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(
            title ?? "",
            style: TextStyle(
                fontSize: FontSizes.normalText1,
                color: ColorConstants.primaryColor,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            handle != null && handle!.isNotEmpty
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 4.sp),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteConstants.products,
                            arguments: {
                              "handle": handle,
                              'title': title,
                            });
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
                                  "View All",
                                  style: TextStyle(
                                      fontSize: FontSizes.normalText1,
                                      color: ColorConstants.textColorGrey
                                          .withOpacity(0.8),
                                      fontWeight: FontWeight.bold),
                                ),
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
                  )
                : const SizedBox(),
            Expanded(
              child: ListView.builder(
                  itemCount: items?.length,
                  itemBuilder: (context, index) {
                    var subCollection = items?[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 4.sp),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteConstants.products,
                              arguments: {
                                "handle": subCollection?.url,
                                'title': '$title / ${subCollection?.title}',
                              });
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
                                    subCollection?.title ?? "",
                                    style: TextStyle(
                                        fontSize: FontSizes.smallText,
                                        color: ColorConstants.textColorGrey
                                            .withOpacity(0.8),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Icon(
                                  CupertinoIcons.forward,
                                  size: 20.sp,
                                  color: ColorConstants.textColorGrey
                                      .withOpacity(0.5),
                                )
                                // collectionItem?.subCollectionItems != null && collectionItem!.subCollectionItems!.isNotEmpty
                                //     ? CustomBackButton() : SizedBox()
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
