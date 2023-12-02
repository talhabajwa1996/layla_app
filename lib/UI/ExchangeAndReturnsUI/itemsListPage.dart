import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Components/ReturnItemCard/returnItemCard.dart';
import 'package:layla_app_dev/UI/ExchangeAndReturnsUI/returnReasonBottomSheet.dart';
import 'package:layla_app_dev/Widgets/Notifiers/Toast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../Controllers/ExchangeAndReturnController/exchangeAndReturnController.dart';
import '../../Widgets/Buttons/CustomFilledButton.dart';
import '../../Widgets/Images/AppLogo.dart';

class ItemsListPage extends StatefulWidget {
  const ItemsListPage({super.key});

  @override
  State<ItemsListPage> createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ItemsListPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<ExchangeAndReturnController>(builder: (context, returnProvider, child) {
      return Column(
        children: [
          SizedBox(
            height: 20.sp,
          ),
          SizedBox(
            width: size.width * 0.7,
            child: Text(
              "What would you like to return?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontSizes.largeText,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.sp),
            child: ListView(
              children: [
                ReturnItemCard()
              ],
            ),
          )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 12.w),
            child: CustomFilledButton(
              title: "Next",
              textColor: ColorConstants.baseColor,
              height: 35.sp,
              width: size.width,
              btnColor: returnProvider.returnReason!.isNotEmpty ? ColorConstants.primaryColor
                  : ColorConstants.grey.withOpacity(0.3),
              onPressed: () {
                if (returnProvider.returnReason!.isNotEmpty) {
                  returnProvider.moveToNextPage();
                } else {
                  showToast("Select an item");
                }
              },
            ),
          )
        ],
      );
    });
  }
}
