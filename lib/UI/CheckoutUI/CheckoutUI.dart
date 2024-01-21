import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/Components/Checkout/CheckoutItemCard.dart';
import 'package:layla_app_dev/Controllers/AddressController/AddressController.dart';
import 'package:layla_app_dev/Controllers/CheckoutController/CheckoutController.dart';
import 'package:layla_app_dev/Services/PaymentGatewayServices/MyFatoorahPaymentServices.dart';
import 'package:provider/provider.dart';
import '../../Controllers/CartControllers/CartController.dart';
import '../../Widgets/Buttons/CustomFilledButton.dart';
import '../../Widgets/TextFields/CustomTextFormField.dart';

class CheckoutUI extends StatefulWidget {
  const CheckoutUI({super.key});

  @override
  State<CheckoutUI> createState() => _CheckoutUIState();
}

class _CheckoutUIState extends State<CheckoutUI> {
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;
  TextEditingController? _addressController;
  TextEditingController? _cityController;
  TextEditingController? _countryController;
  TextEditingController? _postalCodeController;
  TextEditingController? _provinceController;
  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _creditCardFormKey = GlobalKey<FormState>();
  CreditCardModel? _creditCardModel;

  @override
  void initState() {
    var addressProvider =
        Provider.of<AddressController>(context, listen: false);
    _firstNameController =
        TextEditingController(text: addressProvider.addressModel!.firstName);
    _lastNameController =
        TextEditingController(text: addressProvider.addressModel!.lastName);
    _addressController =
        TextEditingController(text: addressProvider.addressModel!.address);
    _cityController =
        TextEditingController(text: addressProvider.addressModel!.city);
    _provinceController =
        TextEditingController(text: addressProvider.addressModel!.province);
    _countryController =
        TextEditingController(text: addressProvider.addressModel!.country);
    _postalCodeController =
        TextEditingController(text: addressProvider.addressModel!.postalCode);
    _provinceController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CHECKOUT')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer2<CartController, CheckoutController>(
              builder: (context, cartController, checkoutController, child) {
            var cartItems =
                cartController.retrieveCartResponse!.cart!.lines!.nodes;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text('Order Summary',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: ColorConstants.textColorGrey)),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartItems!.length,
                    itemBuilder: (context, index) {
                      return CheckoutItemCard(
                        title: cartItems[index].merchandise!.product!.title,
                        color: cartItems[index]
                            .merchandise!
                            .selectedOptions!
                            .firstWhere((element) => element.name == 'Color')
                            .value,
                        size: cartItems[index]
                            .merchandise!
                            .selectedOptions!
                            .firstWhere((element) => element.name == 'Size')
                            .value,
                        image: cartItems[index].merchandise!.image != null
                            ? cartItems[index].merchandise!.image!.url
                            : "",
                        quantity: cartItems[index].quantity.toString(),
                        totalPrice:
                            "${cartItems[index].cost!.totalAmount!.currencyCode} ${double.parse(cartItems[index].cost!.totalAmount!.amount!).toStringAsFixed(3)}",
                      );
                    }),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text('Delivery Details',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: ColorConstants.textColorGrey)),
                ),
                Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _firstNameController,
                        inputAction: TextInputAction.next,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "First Name",
                        validator: (String? value) =>
                            value!.isEmpty ? "Please Enter a value" : null,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _lastNameController,
                        inputAction: TextInputAction.next,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "Last Name",
                        validator: (String? value) =>
                            value!.isEmpty ? "Please Enter a value" : null,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _addressController,
                        inputAction: TextInputAction.next,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        hintText: "Address",
                        validator: (String? value) =>
                            value!.isEmpty ? "Please Enter a value" : null,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _cityController,
                        inputAction: TextInputAction.next,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "City",
                        validator: (String? value) =>
                            value!.isEmpty ? "Please Enter a value" : null,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _provinceController,
                        inputAction: TextInputAction.next,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "Province",
                        validator: (String? value) =>
                            value!.isEmpty ? "Please Enter a value" : null,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _countryController,
                        inputAction: TextInputAction.next,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "Country/Region",
                        validator: (String? value) =>
                            value!.isEmpty ? "Please Enter a value" : null,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _postalCodeController,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.number,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "Postal Code",
                        validator: (String? value) =>
                            value!.isEmpty ? "Please Enter a value" : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                const Divider(),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Subtotal',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(width: 50),
                    Text(
                        '${cartController.retrieveCartResponse!.cart!.cost!.subtotalAmount!.currencyCode} ${double.parse(cartController.retrieveCartResponse!.cart!.cost!.subtotalAmount!.amount!).toStringAsFixed(3)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16))
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Shipping',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                    const SizedBox(width: 50),
                    Text(
                        '${checkoutController.createCheckoutResponse!.checkoutCreate!.checkout!.availableShippingRates!.shippingRates!.first.price!.currencyCode!} ${double.parse(checkoutController.createCheckoutResponse!.checkoutCreate!.checkout!.availableShippingRates!.shippingRates!.first.price!.amount!).toStringAsFixed(3)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 15))
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Total',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(width: 50),
                    Text(
                        '${cartController.retrieveCartResponse!.cart!.cost!.totalAmount!.currencyCode} ${(double.parse(cartController.retrieveCartResponse!.cart!.cost!.totalAmount!.amount!) + double.parse(checkoutController.createCheckoutResponse!.checkoutCreate!.checkout!.availableShippingRates!.shippingRates!.first.price!.amount!)).toStringAsFixed(3)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16))
                  ],
                ),
                // const SizedBox(height: 50),
                // const Divider(),s
                // const SizedBox(height: 50),
                // const Padding(
                //   padding: EdgeInsets.symmetric(vertical: 10),
                //   child: Text('Payment',
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 23,
                //           color: ColorConstants.textColorGrey)),
                // ),
                // CreditCardForm(
                //   formKey: _creditCardFormKey,
                //   // Required
                //   cardNumber: '',
                //   // Required
                //   expiryDate: '',
                //   // Required
                //   cardHolderName: '',
                //   // Required
                //   cvvCode: '',
                //   // Required
                //   // cardNumberKey: 'ss',
                //   // cvvCodeKey: cvvCodeKey,
                //   // expiryDateKey: expiryDateKey,
                //   // cardHolderKey: cardHolderKey,
                //   onCreditCardModelChange: (CreditCardModel data) {
                //     _creditCardModel = data;
                //   },
                //   // Required
                //   obscureCvv: true,
                //   obscureNumber: false,
                //   isHolderNameVisible: true,
                //   isCardNumberVisible: true,
                //   isExpiryDateVisible: true,
                //   enableCvv: true,
                //   cvvValidationMessage: 'Please input a valid CVV',
                //   dateValidationMessage: 'Please input a valid date',
                //   numberValidationMessage: 'Please input a valid number',
                //   // cardNumberValidator: (String? cardNumber){},
                //   // expiryDateValidator: (String? expiryDate){},
                //   // cvvValidator: (String? cvv){},
                //   // cardHolderValidator: (String? cardHolderName){},
                //   onFormComplete: () {
                //     _creditCardFormKey.currentState!.validate();
                //   },
                //   autovalidateMode: AutovalidateMode.disabled,
                //   disableCardNumberAutoFillHints: false,
                //   inputConfiguration: const InputConfiguration(
                //     cardNumberDecoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Number',
                //       hintText: 'XXXX XXXX XXXX XXXX',
                //     ),
                //     expiryDateDecoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Expired Date',
                //       hintText: 'XX/XX',
                //     ),
                //     cvvCodeDecoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'CVV',
                //       hintText: 'XXX',
                //     ),
                //     cardHolderDecoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Card Holder',
                //     ),
                //     cardNumberTextStyle: TextStyle(
                //       fontSize: 10,
                //       color: Colors.black,
                //     ),
                //     cardHolderTextStyle: TextStyle(
                //       fontSize: 10,
                //       color: Colors.black,
                //     ),
                //     expiryDateTextStyle: TextStyle(
                //       fontSize: 10,
                //       color: Colors.black,
                //     ),
                //     cvvCodeTextStyle: TextStyle(
                //       fontSize: 10,
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: CustomFilledButton(
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.9,
                      title: 'Pay',
                      btnColor: ColorConstants.primaryColor,
                      textColor: ColorConstants.white,
                      btnRadius: 5,
                      onPressed: () async {
                        if (_addressFormKey.currentState!.validate()
                            // && _creditCardFormKey.currentState!.validate()
                            ) {
                          // await MyFatoorahPaymentService().executeDirectPayment(
                          //     _creditCardModel!.cardHolderName,
                          //     _creditCardModel!.cardNumber,
                          //     _creditCardModel!.expiryDate.substring(0, 1),
                          //     _creditCardModel!.expiryDate.substring(3, 4),
                          //     _creditCardModel!.cvvCode);
                          await MyFatoorahPaymentService()
                              .executePayment(
                                  context,
                                  (double.parse(cartController
                                          .retrieveCartResponse!
                                          .cart!
                                          .cost!
                                          .totalAmount!
                                          .amount!) +
                                      double.parse(checkoutController
                                          .createCheckoutResponse!
                                          .checkoutCreate!
                                          .checkout!
                                          .availableShippingRates!
                                          .shippingRates!
                                          .first
                                          .price!
                                          .amount!)))
                              .then((paymentResponse) {
                            print("PaymentID: ${paymentResponse!.paymentId!}");
                          });
                        }
                      }),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
