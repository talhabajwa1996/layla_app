import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layla_app_dev/Controllers/CheckoutController/CheckoutController.dart';
import 'package:layla_app_dev/Models/AddressModels/AddressModel.dart';
import 'package:layla_app_dev/Models/CheckoutModels/CreateCheckoutRequestModel.dart';
import 'package:layla_app_dev/Services/API/ServerResponse.dart';
import 'package:layla_app_dev/Services/CheckoutServices/CheckoutService.dart';
import 'package:layla_app_dev/Services/SharedPreferenceService/SharedPreferencesService.dart';
import 'package:layla_app_dev/UI/CheckoutUI/CheckoutUI.dart';
import 'package:layla_app_dev/Widgets/Loaders/AppLoader.dart';
import 'package:layla_app_dev/Widgets/TextFields/CustomTextFormField.dart';
import 'package:provider/provider.dart';
import '../../AppTheme/ColorConstants.dart';
import '../../Controllers/AddressController/AddressController.dart';
import '../../Controllers/CartControllers/CartController.dart';
import '../../Widgets/Buttons/CustomFilledButton.dart';

class ShippingDetailsUI extends StatefulWidget {
  const ShippingDetailsUI({super.key});

  @override
  State<ShippingDetailsUI> createState() => _ShippingDetailsUIState();
}

class _ShippingDetailsUIState extends State<ShippingDetailsUI> {
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;
  TextEditingController? _addressController;
  TextEditingController? _cityController;
  TextEditingController? _countryController;
  TextEditingController? _postalCodeController;
  TextEditingController? _provinceController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _addressController = TextEditingController();
    _cityController = TextEditingController();
    _countryController = TextEditingController();
    _postalCodeController = TextEditingController();
    _provinceController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('SHIPPING DETAILS'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _formKey,
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
                maxLines: 5,
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
              const Expanded(child: SizedBox()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Consumer<CheckoutController>(
                    builder: (context, checkoutController, child) {
                  return checkoutController.isCreatingCheckout
                      ? const AppLoader()
                      : CustomFilledButton(
                          height: 35,
                          width: MediaQuery.of(context).size.width * 0.9,
                          title: 'Continue',
                          btnColor: ColorConstants.primaryColor,
                          textColor: ColorConstants.white,
                          btnRadius: 5,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              AddressModel addressModel = AddressModel(
                                  province: _provinceController!.text,
                                  lastName: _lastNameController!.text,
                                  firstName: _firstNameController!.text,
                                  country: _countryController!.text,
                                  city: _cityController!.text,
                                  address: _addressController!.text,
                                  postalCode: _postalCodeController!.text);
                              SharedPreferencesService().setString(
                                  'address', jsonEncode(addressModel.toJson()));
                              Provider.of<AddressController>(context,
                                      listen: false)
                                  .setAddressModel(addressModel);
                              List<LineItems> _lineItems = <LineItems>[];
                              Provider.of<CartController>(context,
                                      listen: false)
                                  .retrieveCartResponse!
                                  .cart!
                                  .lines!
                                  .nodes!
                                  .forEach((element) {
                                _lineItems.add(LineItems(
                                    quantity: element.quantity,
                                    variantId: element.merchandise!.id));
                              });
                              await CheckoutService()
                                  .createCheckout(
                                      context,
                                      _lineItems,
                                      _addressController!.text,
                                      _cityController!.text,
                                      _provinceController!.text,
                                      _countryController!.text,
                                      _firstNameController!.text,
                                      _lastNameController!.text,
                                      _postalCodeController!.text)
                                  .then((response) {
                                if (response.status == Status.COMPLETED) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => CheckoutUI()));
                                }
                              });
                            }
                          });
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
