import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopify_flutter/models/src/shop/shop.dart';
import 'package:shopify_flutter/shopify/src/shopify_store.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../AppTheme/fontSizes.dart';
import '../../Models/PageModel/aboutUsPageModel.dart';
import '../../Services/ShopifyServices/Queries/getAboutUsPage.dart';
import '../../Services/ShopifyServices/ShopifyServices.dart';
import '../../Utils/HelperFunctions.dart';
import '../Buttons/CustomElevatedButton.dart';
import '../Notifiers/Toast.dart';

Future<dynamic> customBottomSheet(BuildContext context,
    {List<String>? selectionOptions,
    String? title,
    int? initialIndex,
    required void Function(int) onSelectedItemChanged}) async {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext buildContext) {
      return SizedBox(
          height: 500,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  title ?? "",
                  style: const TextStyle(
                      color: ColorConstants.textColorGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                      initialItem: initialIndex ?? 0),
                  // backgroundColor: Colors.white,
                  onSelectedItemChanged: onSelectedItemChanged,
                  itemExtent: 40,
                  magnification: 1,
                  children: List.generate(
                    selectionOptions!.length,
                    (index) => Center(
                      child: Text(
                        selectionOptions[index],
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: CustomElevatedButton.solid(
                    title: localizedText(context)?.submit,
                    onPressed: () => Navigator.pop(context)),
              )
            ],
          ));
    },
  );
}

showAboutUsBottomSheet(BuildContext context) async {
  await ShopifyService().shopifyCustom.customQuery(gqlQuery: getAboutUsPageQuery).then((value) {
    print(value);
    AboutUsData responseModel = AboutUsData.fromJson(value!);
    print(responseModel.page);
    if (responseModel.page != null) {
      showBarModalBottomSheet(
        context: context,
        builder: (context) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.sp),
          child: ListView(
            children:[
              Text(
                responseModel.page?.title ?? "",
                style: TextStyle(fontSize: FontSizes.largeText, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.sp),
                child: Divider(),
              ),
              Html(data: responseModel.page?.body ?? ""),
            ],
          ),
        ),
      );
    } else {
      showToast("Error while fetching data");
    }
  });
}

showPrivacyPolicyBottomSheet(BuildContext context, Shop? shopifyShop) async {
  if(shopifyShop != null){
    var privacyPolicy = shopifyShop.privacyPolicy;
    showBarModalBottomSheet(context: context, builder: (context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.sp),
      child: ListView(
        children: [
          Text(
            privacyPolicy?.title ?? "",
            style: TextStyle(fontSize: FontSizes.largeText, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: Divider(),
          ),
          Html(data: privacyPolicy?.body ?? ""),
        ],
      ),
    ));
  }else{
    await ShopifyService().shopifyStore.getShop().then((value) {
      shopifyShop = value;
      showPrivacyPolicyBottomSheet(context, shopifyShop);
    });
  }
}

showRefundPolicyBottomSheet(BuildContext context, Shop? shopifyShop) async {
  if(shopifyShop != null){
    var refundPolicy = shopifyShop.refundPolicy;
    showBarModalBottomSheet(context: context, builder: (context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.sp),
      child: ListView(
        children: [
          Text(
            refundPolicy?.title ?? "",
            style: TextStyle(fontSize: FontSizes.largeText, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: Divider(),
          ),
          Html(data: refundPolicy?.body ?? ""),
        ],
      ),
    ));
  }
  else{
    await ShopifyService().shopifyStore.getShop().then((value) {
      shopifyShop = value;
      showRefundPolicyBottomSheet(context, shopifyShop);
    });
  }
}


showTermsOfServiceBottomSheet(BuildContext context, Shop? shopifyShop) async {
  if(shopifyShop != null){
    var termsOfService = shopifyShop.termsOfService;
    showBarModalBottomSheet(context: context, builder: (context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.sp),
      child: ListView(
        children: [
          Text(
            termsOfService?.title ?? "",
            style: TextStyle(fontSize: FontSizes.largeText, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: Divider(),
          ),
          Html(data: termsOfService?.body ?? ""),
        ],
      ),
    ));
  }
  else{
    await ShopifyService().shopifyStore.getShop().then((value) {
      shopifyShop = value;
      showTermsOfServiceBottomSheet(context, shopifyShop);
    });
  }
}
