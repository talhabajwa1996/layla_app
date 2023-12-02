import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Controllers/ExchangeAndReturnController/exchangeAndReturnController.dart';
import 'package:layla_app_dev/Models/ReturnModels/returnableFulfillmentResponseModel.dart';
import 'package:layla_app_dev/Services/ShopifyServices/Queries/getReturnableItems.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/UI/ExchangeAndReturnsUI/orderReturnStepsUI.dart';
import 'package:layla_app_dev/Utils/HelperFunctions.dart';
import 'package:layla_app_dev/Widgets/BottomSheets/CustomBottomSheet.dart';
import 'package:layla_app_dev/Widgets/Loaders/AppLoader.dart';
import 'package:layla_app_dev/Widgets/Notifiers/Toast.dart';
import 'package:provider/provider.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../AppTheme/fontSizes.dart';
import '../../Utils/Globals.dart';
import '../../Widgets/Buttons/CustomFilledButton.dart';
import '../../Widgets/CustomAppBar/LogoAppBar.dart';
import '../../Widgets/TextFields/CustomTextFormField.dart';

class ExchangeAndReturnUI extends StatefulWidget {
  const ExchangeAndReturnUI({super.key});

  @override
  State<ExchangeAndReturnUI> createState() => _ExchangeAndReturnUIState();
}

class _ExchangeAndReturnUIState extends State<ExchangeAndReturnUI> {
  TextEditingController emailController = TextEditingController();
  TextEditingController orderNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (shopifyUser != null) {
      emailController.text = shopifyUser!.email!;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: logoAppBar(
          showBackButton: true,
          onBackTap: () {
            Navigator.of(context).pop();
          }),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Returns Center",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: FontSizes.largeText, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20.sp,
              ),
              CustomTextFormField(
                hintText: "Order number*",
                controller: orderNumberController,
                // focusNode: _emailNode,
                // onFieldSubmit: (value) => FocusScope.of(context).requestFocus(_passwordNode),
                inputType: TextInputType.number,
                inputAction: TextInputAction.next,
                // onTap: () => FocusScope.of(context).requestFocus(_emailNode),
                validator: (String? value) => value!.isEmpty ? "Please Enter your order id" : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              SizedBox(
                height: 10.sp,
              ),
              CustomTextFormField(
                hintText: "Email*",
                controller: emailController,
                // focusNode: _emailNode,
                // onFieldSubmit: (value) => FocusScope.of(context).requestFocus(_passwordNode),
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                // onTap: () => FocusScope.of(context).requestFocus(_emailNode),
                validator: (String? value) => value!.isEmpty
                    ? "Please Enter your Email"
                    : !EmailValidator.validate(value)
                        ? "Please Enter a valid Email"
                        : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              SizedBox(
                height: 10.sp,
              ),
              isLoading
                  ? const AppLoader()
                  : CustomFilledButton(
                      height: 35.sp,
                      width: size.width * 0.9,
                      title: "Find Order",
                      btnColor: ColorConstants.primaryColor,
                      textColor: ColorConstants.baseColor,
                      btnRadius: 5.r,
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                        //   setState(() {
                        //     isLoading = true;
                        //   });
                        //
                        //   ShopifyService().shopifyCheckOut.getAllOrders(customerAccessToken).then((value) {
                        //     print(value);
                        //     if (value != null && value.isNotEmpty) {
                        //       var list =
                        //           value.where((element) => element.orderNumber == int.parse(orderNumberController.text)).toList();
                        //       // print(list);
                        //       ShopifyService().shopifyCustom.customQuery(
                        //           gqlQuery: getReturnableItems,
                        //           adminAccess: true,
                        //           variables: {"orderId": list.first.id}).then((value) {
                        //         ReturnableFulfillments responseModel = ReturnableFulfillments.fromJson(value!);
                        //         Provider.of<ExchangeAndReturnController>(context, listen: false).setReturnableItems =
                        //             responseModel;
                        //         print(
                        //             "Processed At:: ${HelperFunctions().convertDate(list.first.processedAt)} at ${HelperFunctions().convertTime(list.first.processedAt)}");
                        //         if (responseModel.edges != null && responseModel.edges!.isNotEmpty) {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                                    return OrderReturnStepsUI(
                                        // orderNumber: list.first.orderNumber.toString(), processedAt: list.first.processedAt);
                                        orderNumber: "11909", processedAt: "2023-11-14T14:08:47Z");
                                  }));
                        //         } else {
                        //           showToast("Items of your order doesn't comply with our return policy.");
                        //         }
                        //       });
                        //       setState(() {
                        //         isLoading = false;
                        //       });
                        //     } else {
                        //       showToast("Didn't find any order");
                        //       setState(() {
                        //         isLoading = false;
                        //       });
                        //     }
                        //   }).onError((error, stackTrace) {
                        //     print(error);
                        //     print(stackTrace.toString());
                        //     setState(() {
                        //       isLoading = false;
                        //     });
                        //     showToast("Error while fetching data");
                        //   });
                        // }
                      },
                    ),
              const Spacer(),
              Text(
                "we accept return of unused and undamaged items according to our return policy.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: FontSizes.extraSmallText,
                    fontWeight: FontWeight.w300,
                    color: ColorConstants.textColorGrey.withOpacity(0.6)),
              ),
              SizedBox(
                height: 10.sp,
              ),
              InkWell(
                onTap: (){
                  showRefundPolicyBottomSheet(context, null);
                },
                child: Text(
                  "view return policy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: FontSizes.extraSmallText,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.secondary1Color,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
