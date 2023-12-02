import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Controllers/ExchangeAndReturnController/exchangeAndReturnController.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../AppTheme/fontSizes.dart';
import '../../UI/ExchangeAndReturnsUI/returnReasonBottomSheet.dart';
import '../../Widgets/Images/AppLogo.dart';

class ReturnItemCard extends StatefulWidget {
  final bool isEditable;
  const ReturnItemCard({super.key, this.isEditable = true});

  @override
  State<ReturnItemCard> createState() => _ReturnItemCardState();
}

class _ReturnItemCardState extends State<ReturnItemCard> {
  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.sizeOf(context);
    return Consumer<ExchangeAndReturnController>(
      builder: (context, returnProvider, child) {
        return InkWell(
          onTap: widget.isEditable ? () {
            showBarModalBottomSheet(
                barrierColor: ColorConstants.black.withOpacity(0.3),
                expand: false, context: context, builder: (context) => ReturnReasonBottomSheet());
          }: null,
          child: Container(
            width: size.width,
            // height: 90.sp,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: ColorConstants.dullWhite,
                borderRadius: BorderRadius.circular(5.r),
                border: returnProvider.returnReason!.isNotEmpty && widget.isEditable ? Border.all(color: ColorConstants.primaryColor) : null),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // productData.images.isNotEmpty
                    //     ? appNetworkImage(productData.image, 75.w, double.infinity, BoxFit.contain)
                    //     :
                    Container(
                      width: 75.w,
                      height: 90.sp,
                      color: ColorConstants.secondaryColor,
                      child: AppLogo(),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Item Name",
                          style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Size / Color",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: FontSizes.extraSmallText, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        // Spacer(),
                        Text(
                          "price",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Spacer(),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "x 1",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ))
                      ],
                    )
                  ],
                ),
                returnProvider.returnReason!.isNotEmpty
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(color: ColorConstants.textColorGrey.withOpacity(0.2)),
                )
                    : SizedBox(),
                returnProvider.returnReason!.isNotEmpty
                    ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              returnProvider.returnReason!,
                              style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.bold),
                            ),
                          ),
                          widget.isEditable ? Text(
                            "Edit",
                            style: TextStyle(
                                fontSize: FontSizes.smallText,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.secondary1Color),
                          ): const SizedBox(),
                        ],
                      ),
                      SizedBox(
                        height: returnProvider.imageFiles.isNotEmpty ? 50.sp : 10.sp,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: returnProvider.imageFiles.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(5.sp),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
                                    child: Image.file(
                                      returnProvider.imageFiles[index],
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                )
                    : SizedBox(),
              ],
            ),
          ),
        );
      }
    );
  }
}
