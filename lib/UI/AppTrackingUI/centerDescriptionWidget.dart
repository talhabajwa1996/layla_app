import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';

import '../../Utils/HelperFunctions.dart';

class CenterDescriptionWidget extends StatelessWidget {
  const CenterDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(localizedText(context)!.allow_app_tracking,
            style: TextStyle(
              height: 1.25,
            color: ColorConstants.textColorGrey,
            fontSize: FontSizes.normalText2,
            fontWeight: FontWeight.w600
          ),),
          SizedBox(height: 5.sp,),
          Text(localizedText(context)!.allow_app_tracking_description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorConstants.textColorGrey,
              fontSize: FontSizes.smallText,
              fontWeight: FontWeight.w400
          ),),
          SizedBox(height: 30.sp,),
          Icon(CupertinoIcons.percent, size: 35.sp,),
          SizedBox(height: 5.sp,),
          Text(localizedText(context)!.personalised_offers_and_exclusive_promotions,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorConstants.textColorGrey,
              fontSize: FontSizes.smallText,
              fontWeight: FontWeight.w400
          ),),
          SizedBox(height: 30.sp,),
          Icon(CupertinoIcons.bag, size: 35.sp,),
          SizedBox(height: 5.sp,),
          Text(localizedText(context)!.personalised_product_recommendation,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorConstants.textColorGrey,
                fontSize: FontSizes.smallText,
                fontWeight: FontWeight.w400
            ),),
        ],
      ),
    );
  }
}
