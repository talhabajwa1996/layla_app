import 'package:shopify_flutter/models/src/shopify_user/shopify_user.dart';

const String storefrontAccessToken = 'd968df86a2c90d332ac7a5135fe270f1';
const String storeUrl = 'https://layla-collection.myshopify.com';
const String storefrontApiVersion = '2023-07';
const String adminAccessToken = "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";
String customerAccessToken = "";
ShopifyUser? shopifyUser;
List<String> corporateInfoList = ["About Us", "Blog", "Privacy Policy", "Refund Policy", "Terms of service"];
List<String> customerServiceList = ["FAQs", "Contact Us", "Exchanges & Returns"];
List<String> returnReasonsList = [
  "Looks different to image on site",
  "Arrived too late",
  "Doesn't suit me",
  "Incorrect item received",
  "Parcel damage on arrival",
  "Others (Please Specify in additional notes)"
];
