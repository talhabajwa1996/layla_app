import 'package:shopify_flutter/models/src/shopify_user/shopify_user.dart';

const String storefrontAccessToken = 'd968df86a2c90d332ac7a5135fe270f1';
const String storeUrl = 'https://layla-collection.myshopify.com';
const String storefrontApiVersion = '2023-07';
const String adminAccessToken = "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";
String customerAccessToken = "";
ShopifyUser? shopifyUser;
List<String> corporateInfoList = [
  "About Us",
  "Blog",
  "Privacy Policy",
  "Refund Policy",
  "Terms of service"
];
List<String> customerServiceList = [
  "FAQs",
  "Contact Us",
  "Exchanges & Returns"
];
List<String> returnReasonsList = [
  "Looks different to image on site",
  "Arrived too late",
  "Doesn't suit me",
  "Incorrect item received",
  "Parcel damage on arrival",
  "Others (Please Specify in additional notes)"
];

String? cartId;

String myFatoorahApiKey =
'_4eaFhgnnwilM33ciCIWf1b7hkIc63JMs3oZb2Ll9EUKe1gXRoq6SEAEsUgsbNrTbKI4bWuJLHAjed5BmPOuwk5WF_k8KtD03VMA12tCerRlTQYUjE7R0b2toqcMPVlfsZa4xncg5aa63ol10zd2ntu3rXj7zetwd_Xi3wEYZA9Nig8HlJeeYKI6LOg1BM3YGglg6cyOUbEPRMKRVLbQ-OrGUnKCYVxDt1M5jISfOu_F7pqlbF3o-BWDfpBTjIlopiyomjY3F9YuoNPQ34aDQj0GgGmRgxxubLilN760COeRgduwDtr-mYvwPOo9tgg_MxtJ9GjrBdZuksKHM7fPAiEQEOvBVr8rAKOfKd-eloDRVrPGrASsQXqTh1Tcizoek3GsOvRGnEa8CHeaB0-Sfc0SCLCl4FyU4aNdEnaS9PKoR8vLf_E-aX1XNf5K14QW4FFFzP_XqS4Rzd4oLQEgPV_8BuE57yOYb29pg2-_LM1-6s4cwHdhhpRpLxHs09JJFvMHxI_X1sv5Nb4vsE5ao9R6SKJ4d3k16Kl8Pg_S4gZm_TZ53llrCP6naWNbRPUgbyrwYDJSBgXMBCqXw-OjMVlvblh6PoN7TIGIBMDF6QyP53HRfYm-KtDidP9Wal1-KCjuw6cdXGev_ezLCKevabCFIFpZd8uyu5OVeH7dCDi19WzTrGom2Tw7UX2jzYCTB9yIEw';
    // 'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL';
