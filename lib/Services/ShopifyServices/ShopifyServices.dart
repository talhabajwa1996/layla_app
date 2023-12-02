import 'package:flutter/material.dart';
import 'package:layla_app_dev/Services/SharedPreferenceService/SharedPreferencesService.dart';
import 'package:layla_app_dev/Utils/Constants/KeysConstants.dart';
import 'package:layla_app_dev/Utils/Globals.dart';
import 'package:shopify_flutter/shopify/shopify.dart';
import 'package:shopify_flutter/shopify/src/shopify_custom.dart';
import 'package:shopify_flutter/shopify_config.dart';
import '../../Utils/Constants/RouteConstants.dart';

class ShopifyService {
  ShopifyCustomer shopifyCustomer = ShopifyCustomer.instance;
  ShopifyAuth shopifyAuth = ShopifyAuth.instance;
  ShopifyBlog shopifyBlog = ShopifyBlog.instance;
  ShopifyStore shopifyStore = ShopifyStore.instance;
  ShopifyCustom shopifyCustom = ShopifyCustom.instance;
  ShopifyCheckout shopifyCheckOut = ShopifyCheckout.instance;

  initShopify() {
    ShopifyConfig.setConfig(
        storefrontAccessToken: storefrontAccessToken,
        storeUrl: storeUrl,
        storefrontApiVersion: storefrontApiVersion,
        adminAccessToken: adminAccessToken);
  }

  getCurrentUserDetails() async {
    await shopifyAuth.currentUser().then((value) async {
      if (value != null) {
        shopifyUser = value;
        await shopifyAuth.currentCustomerAccessToken.then((value) {
          customerAccessToken = value!;
          print("Access Token:: $customerAccessToken");
        });
      }
    });
  }

  signOutUser(BuildContext context) {
    shopifyAuth.signOutCurrentUser();
    shopifyUser = null;
    SharedPreferencesService().setString(KeysConstants.isUserLoggedIn, "false");
    Navigator.of(context).pushReplacementNamed(RouteConstants.initialRoute);
  }
}
