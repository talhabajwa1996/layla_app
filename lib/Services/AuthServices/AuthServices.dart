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

  Future<ServerResponse<ShopifyUser>> createUserWithEmailAndPassword(
      BuildContext context,
      String firstName,
      String lastName,
      String email,
      String password) async {
    var controller = Provider.of<AuthController>(context, listen: false);
    try {
      controller.setSignupLoading(true);
      ShopifyUser user = await shopifyAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName);
      controller.setSignupLoading(false);
      return ServerResponse.completed(user);
    } on Exception catch (e) {
      controller.setSignupLoading(false);
      return ServerResponse.error(e.toString());
    }
  }

  Future<ServerResponse<void>> sendPasswordResetEmail(
      BuildContext context, String email) async {
    var controller = Provider.of<AuthController>(context, listen: false);
    try {
      controller.setForgetPasswordLoading(true);
      await shopifyAuth.sendPasswordResetEmail(email: email);
      controller.setForgetPasswordLoading(false);
      return ServerResponse.completed(null);
    } on Exception catch (e) {
      controller.setForgetPasswordLoading(false);
      return ServerResponse.error(e.toString());
    }
  }
}
