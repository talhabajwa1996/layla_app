import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Components/ReturnItemCard/returnItemCard.dart';
import 'package:layla_app_dev/Controllers/ExchangeAndReturnController/exchangeAndReturnController.dart';
import 'package:provider/provider.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../AppTheme/fontSizes.dart';
import '../../Widgets/Buttons/CustomFilledButton.dart';
import '../../Widgets/Images/AppLogo.dart';

class ReviewReturnPage extends StatefulWidget {
  const ReviewReturnPage({super.key});

  @override
  State<ReviewReturnPage> createState() => _ReviewReturnPageState();
}

class _ReviewReturnPageState extends State<ReviewReturnPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<ExchangeAndReturnController>(
      builder: (context, returnProvider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: ListView(
            children: [
              SizedBox(
                height: 20.sp,
              ),
              SizedBox(
                width: size.width * 0.7,
                child: Text(
                  "Review your return",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: FontSizes.largeText,
                  ),
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Text(
                "Return Items",
                style: TextStyle(
                  fontSize: FontSizes.normalText1,
                    fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.sp,
              ),
              ReturnItemCard(isEditable: false,),
              SizedBox(height: 30.sp,),
              Text(
                "Resolution",
                style: TextStyle(
                  fontSize: FontSizes.normalText1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Container(
                // height: 35.sp,
                width: size.width,
                decoration:
                BoxDecoration(color: ColorConstants.dullWhite, borderRadius: BorderRadius.circular(5.r)),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      returnProvider.resolution == "Exchange" ? "Refund to store credit": returnProvider.resolution!,
                      style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w400),
                    ),
                    returnProvider.resolution =="Exchange" ? Text(
                      "Exchange",
                      style: TextStyle(
                          fontSize: FontSizes.extraSmallText,
                          color: ColorConstants.textColorGrey.withOpacity(0.6),
                          fontWeight: FontWeight.w400),
                    ): SizedBox(),
                  ],
                ),
              ),
              SizedBox(height: 30.sp,),
              Text(
                "Shipping",
                style: TextStyle(
                  fontSize: FontSizes.normalText1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Container(
                // height: 35.sp,
                width: size.width,
                decoration:
                BoxDecoration(color: ColorConstants.dullWhite, borderRadius: BorderRadius.circular(5.r)),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ship with us",
                            style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "you will get the shipping instructions after the request is approved.",
                            style: TextStyle(fontSize: FontSizes.extraSmallText,color: ColorConstants.textColorGrey.withOpacity(0.6), fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.sp,),
              Text(
                "Summary",
                style: TextStyle(
                  fontSize: FontSizes.normalText1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: ColorConstants.dullWhite,
                  borderRadius: BorderRadius.circular(5.r)
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Return Credits (1)",
                          style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "KWD 5.000",
                          style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Return Items",
                          style: TextStyle(fontSize: FontSizes.extraSmallText, fontWeight: FontWeight.w400, color: ColorConstants.textColorGrey.withOpacity(0.6)),
                        ),
                        Text(
                          "KWD 5.000",
                          style: TextStyle(fontSize: FontSizes.extraSmallText, fontWeight: FontWeight.w400,color: ColorConstants.textColorGrey.withOpacity(0.6)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                          color: ColorConstants.textColorGrey.withOpacity(0.2)
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Refund",
                          style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "KWD 5.000",
                          style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),

              ),
              SizedBox(height: 10.sp,),
              Text(
                "*The actual refund amount is subject to applied discounts, taxes, shipping costs and store policy.",
                style: TextStyle(fontSize: FontSizes.extraSmallText,color: ColorConstants.textColorGrey.withOpacity(0.6), fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 30.sp,),
              CustomFilledButton(
                title: "Submit",
                textColor: ColorConstants.baseColor,
                height: 35.sp,
                width: size.width,
                btnColor: ColorConstants.primaryColor,
                onPressed: () {
                  // filteringProvider.setFiltersMap();
                  // print("Map:: ${filteringProvider.filters}");
                  // Navigator.pop(context, true);
                },
              ),
              SizedBox(height: 30.sp,),
            ],
          ),
        );
      }
    );
  }
}
