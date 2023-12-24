class AddItemToCartResponseModel {
  CartLinesAdd? cartLinesAdd;

  AddItemToCartResponseModel({this.cartLinesAdd});

  AddItemToCartResponseModel.fromJson(Map<String, dynamic> json) {
    cartLinesAdd = json['cartLinesAdd'] != null
        ? new CartLinesAdd.fromJson(json['cartLinesAdd'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartLinesAdd != null) {
      data['cartLinesAdd'] = this.cartLinesAdd!.toJson();
    }
    return data;
  }
}

class CartLinesAdd {
  Cart? cart;
  List<UserErrors>? userErrors;

  CartLinesAdd({this.cart, this.userErrors});

  CartLinesAdd.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    if (json['userErrors'] != null) {
      userErrors = <UserErrors>[];
      json['userErrors'].forEach((v) {
        userErrors!.add(new UserErrors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.toJson();
    }
    if (this.userErrors != null) {
      data['userErrors'] = this.userErrors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  Cost? cost;

  Cart({this.cost});

  Cart.fromJson(Map<String, dynamic> json) {
    cost = json['cost'] != null ? new Cost.fromJson(json['cost']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cost != null) {
      data['cost'] = this.cost!.toJson();
    }
    return data;
  }
}

class Cost {
  CheckoutChargeAmount? checkoutChargeAmount;

  Cost({this.checkoutChargeAmount});

  Cost.fromJson(Map<String, dynamic> json) {
    checkoutChargeAmount = json['checkoutChargeAmount'] != null
        ? new CheckoutChargeAmount.fromJson(json['checkoutChargeAmount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.checkoutChargeAmount != null) {
      data['checkoutChargeAmount'] = this.checkoutChargeAmount!.toJson();
    }
    return data;
  }
}

class CheckoutChargeAmount {
  String? amount;
  String? currencyCode;

  CheckoutChargeAmount({this.amount, this.currencyCode});

  CheckoutChargeAmount.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currencyCode = json['currencyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currencyCode'] = this.currencyCode;
    return data;
  }
}

class UserErrors {
  List<String>? field;
  String? message;

  UserErrors({this.field, this.message});

  UserErrors.fromJson(Map<String, dynamic> json) {
    field = json['field'].cast<String>();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['message'] = this.message;
    return data;
  }
}