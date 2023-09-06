import 'package:flutter/cupertino.dart';
import 'package:layla_app_dev/Controllers/AuthController/AuthController.dart';
import 'package:layla_app_dev/Services/ServerResponse.dart';
import 'package:provider/provider.dart';
import 'package:shopify_flutter/models/src/shopify_user/shopify_user.dart';
import 'package:shopify_flutter/shopify/src/shopify_auth.dart';

class AuthServices {
  ShopifyAuth shopifyAuth = ShopifyAuth.instance;

  Future<ServerResponse<ShopifyUser>> signInWithEmailAndPassword(
      BuildContext context,
      {required String email,
      required String password}) async {
    var controller = Provider.of<AuthController>(context, listen: false);
    try {
      controller.setLoginLoading(true);
      ShopifyUser user = await shopifyAuth.signInWithEmailAndPassword(
          email: email, password: password);
      controller.setLoginLoading(false);
      return ServerResponse.completed(user);
    } on Exception catch (e) {
      controller.setLoginLoading(false);
      return ServerResponse.error(e.toString());
    }
  }
}
