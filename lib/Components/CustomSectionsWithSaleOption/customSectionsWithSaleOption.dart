import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';

class CustomSectionsWithSaleOption extends StatefulWidget {
  final String? title;
  final dynamic itemsList;

  const CustomSectionsWithSaleOption({super.key, this.title, this.itemsList});

  @override
  State<CustomSectionsWithSaleOption> createState() => _CustomSectionsWithSaleOptionState();
}

class _CustomSectionsWithSaleOptionState extends State<CustomSectionsWithSaleOption> {
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
                itemCount: widget.itemsList.length ?? 0,
                itemBuilder: (_, index) {
                  return itemCard("Chain Print Elastic Maxie", "10.99 \$", isOnSale: true);
                }),
          )
        ],
      ),
    );
  }

  Widget itemCard(String itemName, String price, {bool isOnSale = false, String? discountedPrice}) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 135.w,
                height: 197.sp,
                color: ColorConstants.secondaryColor,
              ),
              isOnSale
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 40.w,
                          height: 25.sp,
                          decoration:
                              BoxDecoration(color: ColorConstants.primaryColor, borderRadius: BorderRadius.circular(10.r)),
                          child: Center(
                            child: Text(
                              "10%",
                              style: TextStyle(
                                  color: ColorConstants.secondaryColor,
                                  fontSize: FontSizes.extraSmallText,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox()
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
            children: [
              Text(
                price,
                style: TextStyle(
                    fontSize: isOnSale ? FontSizes.extraSmallText : FontSizes.smallText,
                    fontWeight: FontWeight.w600,
                    color: isOnSale ? ColorConstants.textColorGrey.withOpacity(0.6) : ColorConstants.textColorGrey,
                    decoration: isOnSale ? TextDecoration.lineThrough : TextDecoration.none),
              ),
              SizedBox(
                width: isOnSale ? 3.w : 0,
              ),
              isOnSale
                  ? Text(
                      price,
                      style: TextStyle(
                        fontSize: FontSizes.smallText,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.textColorGrey,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
