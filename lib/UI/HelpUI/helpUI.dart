import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Utils/Globals.dart';
import 'package:shopify_flutter/models/src/shop/shop.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../AppTheme/fontSizes.dart';
import '../../Services/ShopifyServices/ShopifyServices.dart';
import '../../Widgets/BottomSheets/CustomBottomSheet.dart';
import '../../Widgets/Buttons/customBackButton.dart';
import '../CustomerServicesUI/contactUsUI.dart';
import '../CustomerServicesUI/faqsUI.dart';
import '../CustomerServicesUI/ourLocationsUI.dart';
import '../ExchangeAndReturnsUI/exchangeAndReturnUI.dart';

class HelpUI extends StatefulWidget {
  const HelpUI({super.key});

  @override
  State<HelpUI> createState() => _HelpUIState();
}

class _HelpUIState extends State<HelpUI> {
  Shop? shopifyShop;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShopifyService().shopifyStore.getShop().then((value) {
      shopifyShop = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
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
          "Help",
          style: TextStyle(fontSize: FontSizes.normalText1, color: ColorConstants.primaryColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: corporateInfoList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: InkWell(
                    onTap: () {
                      if (index == 0) {
                        showAboutUsBottomSheet(context);
                      } else if (index == 1) {
                        ///Blogs Page
                      } else if (index == 2) {
                        showPrivacyPolicyBottomSheet(context, shopifyShop);
                      } else if (index == 3) {
                        showRefundPolicyBottomSheet(context, shopifyShop);
                      } else if (index == 4) {
                        showTermsOfServiceBottomSheet(context, shopifyShop);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: ColorConstants.textColorGrey.withOpacity(0.3), width: 0.5))),
                      child: ListTile(
                        dense: true,
                        title: Text(
                          corporateInfoList[index],
                          style: TextStyle(
                              fontSize: FontSizes.smallText,
                              color: ColorConstants.textColorGrey.withOpacity(0.8),
                              fontWeight: FontWeight.w700),
                        ),
                        trailing: Icon(
                          CupertinoIcons.forward,
                          size: 15.sp,
                        ),
                      ),
                    ),
                  ),
                );
              }),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: customerServiceList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: InkWell(
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return FAQsUI();
                        }));
                      }else if (index == 1) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ContactUsUI();
                        }));
                      } else if (index == 2) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ExchangeAndReturnUI();
                        }));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: ColorConstants.textColorGrey.withOpacity(0.3), width: 0.5))),
                      child: ListTile(
                        dense: true,
                        title: Text(
                          customerServiceList[index],
                          style: TextStyle(
                              fontSize: FontSizes.smallText,
                              color: ColorConstants.textColorGrey.withOpacity(0.8),
                              fontWeight: FontWeight.w700),
                        ),
                        trailing: Icon(
                          CupertinoIcons.forward,
                          size: 15.sp,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
