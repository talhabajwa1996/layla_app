import 'package:flutter/material.dart';
import 'package:layla_app_dev/Services/SharedPreferenceService/SharedPreferencesService.dart';
import 'package:layla_app_dev/Utils/Constants/KeysConstants.dart';
import 'package:layla_app_dev/Utils/Globals.dart';
import 'package:shopify_flutter/shopify/src/shopify_auth.dart';
import 'package:shopify_flutter/shopify/src/shopify_blog.dart';
import 'package:shopify_flutter/shopify/src/shopify_custom.dart';
import 'package:shopify_flutter/shopify/src/shopify_customer.dart';
import 'package:shopify_flutter/shopify/src/shopify_store.dart';
import 'package:shopify_flutter/shopify_config.dart';

import '../../Utils/Constants/RouteConstants.dart';

class ShopifyService {

  ShopifyCustomer shopifyCustomer = ShopifyCustomer.instance;
  ShopifyAuth shopifyAuth = ShopifyAuth.instance;
  ShopifyBlog shopifyBlog = ShopifyBlog.instance;
  ShopifyStore shopifyStore = ShopifyStore.instance;
  ShopifyCustom shopifyCustom = ShopifyCustom.instance;

  initShopify() {
    ShopifyConfig.setConfig(
        storefrontAccessToken: storefrontAccessToken, storeUrl: storeUrl, storefrontApiVersion: storefrontApiVersion);
  }

  getCurrentUserDetails() async {
    await shopifyAuth.currentUser().then((value){
      shopifyUser = value;
    });
  }

  signOutUser(BuildContext context){
    shopifyAuth.signOutCurrentUser();
    SharedPreferencesService().setString(KeysConstants.isUserLoggedIn, "false");
    Navigator.of(context).pushReplacementNamed(RouteConstants.initialRoute);
  }
}
