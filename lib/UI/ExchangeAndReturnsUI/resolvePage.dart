import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../AppTheme/fontSizes.dart';
import '../../Controllers/ExchangeAndReturnController/exchangeAndReturnController.dart';

class ResolvePage extends StatefulWidget {
  const ResolvePage({super.key});

  @override
  State<ResolvePage> createState() => _ResolvePageState();
}

class _ResolvePageState extends State<ResolvePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          SizedBox(
            height: 20.sp,
          ),
          SizedBox(
            width: size.width * 0.7,
            child: Text(
              "How can we resolve it?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontSizes.largeText,
              ),
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.sp),
            child: InkWell(
              onTap: () {
                Provider.of<ExchangeAndReturnController>(context, listen: false).setResolution("Exchange");
                Provider.of<ExchangeAndReturnController>(context, listen: false).moveToNextPage();
              },
              child: Container(
                // height: 35.sp,
                width: size.width,
                decoration: BoxDecoration(color: ColorConstants.dullWhite, borderRadius: BorderRadius.circular(5.r)),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Refund to store credit",
                          style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Exchange",
                          style: TextStyle(
                              fontSize: FontSizes.extraSmallText,
                              color: ColorConstants.textColorGrey.withOpacity(0.6),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Icon(
                      CupertinoIcons.forward,
                      size: FontSizes.smallText,
                      color: ColorConstants.textColorGrey.withOpacity(0.6),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.sp),
            child: InkWell(
              onTap: () {
                Provider.of<ExchangeAndReturnController>(context, listen: false)
                    .setResolution("Refund to original payment method");
                Provider.of<ExchangeAndReturnController>(context, listen: false).moveToNextPage();
              },
              child: Container(
                // height: 35.sp,
                width: size.width,
                decoration: BoxDecoration(color: ColorConstants.dullWhite, borderRadius: BorderRadius.circular(5.r)),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Refund to original payment method",
                      style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      CupertinoIcons.forward,
                      size: FontSizes.smallText,
                      color: ColorConstants.textColorGrey.withOpacity(0.6),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
