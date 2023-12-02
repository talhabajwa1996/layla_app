import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Controllers/ExchangeAndReturnController/exchangeAndReturnController.dart';
import 'package:layla_app_dev/UI/ExchangeAndReturnsUI/itemsListPage.dart';
import 'package:layla_app_dev/UI/ExchangeAndReturnsUI/resolvePage.dart';
import 'package:layla_app_dev/UI/ExchangeAndReturnsUI/reviewReturnPage.dart';
import 'package:layla_app_dev/UI/ExchangeAndReturnsUI/shipWithUsPage.dart';
import 'package:provider/provider.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../AppTheme/fontSizes.dart';
import '../../Utils/HelperFunctions.dart';
import '../../Widgets/Buttons/customBackButton.dart';

class OrderReturnStepsUI extends StatefulWidget {
  final String? orderNumber;
  final String? processedAt;

  const OrderReturnStepsUI({super.key, this.orderNumber, this.processedAt});

  @override
  State<OrderReturnStepsUI> createState() => _OrderReturnStepsUIState();
}

class _OrderReturnStepsUIState extends State<OrderReturnStepsUI> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExchangeAndReturnController>(builder: (context, returnProvider, child) {
      var returnItemsData = returnProvider.returnableFulfillments?.edges;
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: Padding(
              padding: EdgeInsets.only(left: 15.w, top: 8.sp, bottom: 8.sp),
              child: CustomBackButton(
                onTap: () {
                  if (returnProvider.pageController.page != 0) {
                    returnProvider.moveToPreviousPage();
                  } else {
                    returnProvider.resetProvider();
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            title: Column(
              children: [
                Text(
                  "Order# ${widget.orderNumber}",
                  style: TextStyle(
                      fontSize: FontSizes.normalText2, color: ColorConstants.textColorGrey, fontWeight: FontWeight.w600),
                ),
                Text(
                  "${HelperFunctions().convertDate(widget.processedAt)} at ${HelperFunctions().convertTime(widget.processedAt)}",
                  style: TextStyle(
                      fontSize: FontSizes.smallText,
                      color: ColorConstants.textColorGrey.withOpacity(0.8),
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              LinearProgressIndicator(
                value: returnProvider.progressValue,
              ),
              Expanded(
                  child: PageView(
                controller: returnProvider.pageController,
                physics: const NeverScrollableScrollPhysics(),
                // onPageChanged: ,
                children: const [
                  ItemsListPage(),
                  ResolvePage(),
                  ShipWithUsPage(),
                  ReviewReturnPage(),
                ],
              ))
            ],
          ));
    });
  }
}
