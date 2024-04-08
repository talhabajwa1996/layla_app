import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:layla_app_dev/Utils/Globals.dart';
import 'package:my_fatoorah/my_fatoorah.dart';

class MyFatoorahPaymentService {
  Future<PaymentResponse?> executePayment(
      BuildContext context, double amount) async {
    try {
      PaymentResponse response = await MyFatoorah.startPayment(
        afterPaymentBehaviour: AfterPaymentBehaviour.BeforeCallbackExecution,
        context: context,
        request: MyfatoorahRequest.test(
            currencyIso: Country.Kuwait,
            successUrl:
                'https://banner2.cleanpng.com/20171209/2ff/web-page-registration-success-flag-material-5a2c2a5d3d20d3.8268076415128438692504.jpg',
            errorUrl:
                'https://banner2.cleanpng.com/20171202/76f/red-cross-mark-png-file-5a2245bd7d68f5.1453718115121955175137.jpg',
            invoiceAmount: amount,
            language: ApiLanguage.English,
            token: myFatoorahApiKey),
      );
      log("Payment Response: " + response.paymentId.toString());
      return response;
    } on Exception catch (e) {
      print(e);
    }
  }
}
