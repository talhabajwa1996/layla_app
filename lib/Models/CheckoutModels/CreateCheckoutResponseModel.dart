class CreateCheckoutResponseModel {
  CheckoutCreate? checkoutCreate;

  CreateCheckoutResponseModel({this.checkoutCreate});

  CreateCheckoutResponseModel.fromJson(Map<String, dynamic> json) {
    checkoutCreate = json['checkoutCreate'] != null
        ? new CheckoutCreate.fromJson(json['checkoutCreate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.checkoutCreate != null) {
      data['checkoutCreate'] = this.checkoutCreate!.toJson();
    }
    return data;
  }
}

class CheckoutCreate {
  Checkout? checkout;
  List<CheckoutUserErrors>? checkoutUserErrors;

  CheckoutCreate({this.checkout, this.checkoutUserErrors});

  CheckoutCreate.fromJson(Map<String, dynamic> json) {
    checkout =
        json['checkout'] != null ? Checkout.fromJson(json['checkout']) : null;
    if (json['checkoutUserErrors'] != null) {
      checkoutUserErrors = <CheckoutUserErrors>[];
      json['checkoutUserErrors'].forEach((v) {
        checkoutUserErrors!.add(CheckoutUserErrors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.checkout != null) {
      data['checkout'] = this.checkout!.toJson();
    }
    if (this.checkoutUserErrors != null) {
      data['checkoutUserErrors'] =
          this.checkoutUserErrors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Checkout {
  String? id;
  PaymentDue? paymentDue;
  PaymentDue? totalPrice;
  PaymentDue? subtotalPrice;
  PaymentDue? totalTax;
  AvailableShippingRates? availableShippingRates;
  bool? taxesIncluded;

  Checkout(
      {this.id,
      this.paymentDue,
      this.totalPrice,
      this.subtotalPrice,
      this.totalTax,
      this.availableShippingRates,
      this.taxesIncluded});

  Checkout.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentDue = json['paymentDue'] != null
        ? new PaymentDue.fromJson(json['paymentDue'])
        : null;
    totalPrice = json['totalPrice'] != null
        ? new PaymentDue.fromJson(json['totalPrice'])
        : null;
    subtotalPrice = json['subtotalPrice'] != null
        ? new PaymentDue.fromJson(json['subtotalPrice'])
        : null;
    totalTax = json['totalTax'] != null
        ? new PaymentDue.fromJson(json['totalTax'])
        : null;
    availableShippingRates = json['availableShippingRates'] != null
        ? new AvailableShippingRates.fromJson(json['availableShippingRates'])
        : null;
    taxesIncluded = json['taxesIncluded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.paymentDue != null) {
      data['paymentDue'] = this.paymentDue!.toJson();
    }
    if (this.totalPrice != null) {
      data['totalPrice'] = this.totalPrice!.toJson();
    }
    if (this.subtotalPrice != null) {
      data['subtotalPrice'] = this.subtotalPrice!.toJson();
    }
    if (this.totalTax != null) {
      data['totalTax'] = this.totalTax!.toJson();
    }
    if (this.availableShippingRates != null) {
      data['availableShippingRates'] = this.availableShippingRates!.toJson();
    }
    data['taxesIncluded'] = this.taxesIncluded;
    return data;
  }
}

class PaymentDue {
  String? amount;
  String? currencyCode;

  PaymentDue({this.amount, this.currencyCode});

  PaymentDue.fromJson(Map<String, dynamic> json) {
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

class AvailableShippingRates {
  bool? ready;
  List<ShippingRates>? shippingRates;

  AvailableShippingRates({this.ready, this.shippingRates});

  AvailableShippingRates.fromJson(Map<String, dynamic> json) {
    ready = json['ready'];
    if (json['shippingRates'] != null) {
      shippingRates = <ShippingRates>[];
      json['shippingRates'].forEach((v) {
        shippingRates!.add(new ShippingRates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ready'] = this.ready;
    if (this.shippingRates != null) {
      data['shippingRates'] =
          this.shippingRates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingRates {
  String? title;
  PaymentDue? price;

  ShippingRates({this.title, this.price});

  ShippingRates.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price =
        json['price'] != null ? new PaymentDue.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    return data;
  }
}

class CheckoutUserErrors {
  List<String>? field;
  String? message;

  CheckoutUserErrors({this.field, this.message});

  CheckoutUserErrors.fromJson(Map<String, dynamic> json) {
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
