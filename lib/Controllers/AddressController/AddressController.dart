import 'package:flutter/cupertino.dart';
import 'package:layla_app_dev/Models/AddressModels/AddressModel.dart';

class AddressController extends ChangeNotifier {
  AddressModel? _addressModel;

  AddressModel? get addressModel => _addressModel;

  void setAddressModel(AddressModel model) {
    _addressModel = model;
  }
}
