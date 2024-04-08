class CompleteCheckoutRequestModel {
  List<CreateordersData>? createordersData;

  CompleteCheckoutRequestModel({this.createordersData});

  CompleteCheckoutRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['createordersData'] != null) {
      createordersData = <CreateordersData>[];
      json['createordersData'].forEach((v) {
        createordersData!.add(new CreateordersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.createordersData != null) {
      data['createordersData'] =
          this.createordersData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreateordersData {
  String? location;
  CusomerInfo? cusomerInfo;
  String? financialStatus;
  List<Transactions>? transactions;
  List<Discount>? discount;
  List<ShippingCharge>? shippingCharge;
  List<Taxes>? taxes;
  List<CartItems>? cartItems;

  CreateordersData(
      {this.location,
        this.cusomerInfo,
        this.financialStatus,
        this.transactions,
        this.discount,
        this.shippingCharge,
        this.taxes,
        this.cartItems});

  CreateordersData.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    cusomerInfo = json['cusomerInfo'] != null
        ? new CusomerInfo.fromJson(json['cusomerInfo'])
        : null;
    financialStatus = json['financial_status'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
    if (json['discount'] != null) {
      discount = <Discount>[];
      json['discount'].forEach((v) {
        discount!.add(new Discount.fromJson(v));
      });
    }
    if (json['shippingCharge'] != null) {
      shippingCharge = <ShippingCharge>[];
      json['shippingCharge'].forEach((v) {
        shippingCharge!.add(new ShippingCharge.fromJson(v));
      });
    }
    if (json['taxes'] != null) {
      taxes = <Taxes>[];
      json['taxes'].forEach((v) {
        taxes!.add(new Taxes.fromJson(v));
      });
    }
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    if (this.cusomerInfo != null) {
      data['cusomerInfo'] = this.cusomerInfo!.toJson();
    }
    data['financial_status'] = this.financialStatus;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    if (this.discount != null) {
      data['discount'] = this.discount!.map((v) => v.toJson()).toList();
    }
    if (this.shippingCharge != null) {
      data['shippingCharge'] =
          this.shippingCharge!.map((v) => v.toJson()).toList();
    }
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CusomerInfo {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  bool? verifiedEmail;
  List<Addresses>? addresses;

  CusomerInfo(
      {this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.verifiedEmail,
        this.addresses});

  CusomerInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    verifiedEmail = json['verified_email'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['verified_email'] = this.verifiedEmail;
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  String? address1;
  String? city;
  String? phone;
  String? zip;
  String? lastName;
  String? firstName;
  String? country;

  Addresses(
      {this.address1,
        this.city,
        this.phone,
        this.zip,
        this.lastName,
        this.firstName,
        this.country});

  Addresses.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    city = json['city'];
    phone = json['phone'];
    zip = json['zip'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address1'] = this.address1;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['zip'] = this.zip;
    data['last_name'] = this.lastName;
    data['first_name'] = this.firstName;
    data['country'] = this.country;
    return data;
  }
}

class Transactions {
  String? transactionId;
  String? status;
  String? gateway;
  String? processingMethod;
  double? amount;

  Transactions(
      {this.transactionId,
        this.status,
        this.gateway,
        this.processingMethod,
        this.amount});

  Transactions.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    status = json['status'];
    gateway = json['gateway'];
    processingMethod = json['processing_method'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionId'] = this.transactionId;
    data['status'] = this.status;
    data['gateway'] = this.gateway;
    data['processing_method'] = this.processingMethod;
    data['amount'] = this.amount;
    return data;
  }
}

class Discount {
  String? code;
  String? amount;
  String? type;

  Discount({this.code, this.amount, this.type});

  Discount.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    amount = json['amount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['amount'] = this.amount;
    data['type'] = this.type;
    return data;
  }
}

class ShippingCharge {
  String? handle;
  String? price;
  String? title;

  ShippingCharge({this.handle, this.price, this.title});

  ShippingCharge.fromJson(Map<String, dynamic> json) {
    handle = json['handle'];
    price = json['price'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['handle'] = this.handle;
    data['price'] = this.price;
    data['title'] = this.title;
    return data;
  }
}

class Taxes {
  double? price;
  double? rate;
  String? title;

  Taxes({this.price, this.rate, this.title});

  Taxes.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    rate = json['rate'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['rate'] = this.rate;
    data['title'] = this.title;
    return data;
  }
}

class CartItems {
  int? productId;
  int? variantId;
  int? quantity;

  CartItems({this.productId, this.variantId, this.quantity});

  CartItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    variantId = json['variant_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['variant_id'] = this.variantId;
    data['quantity'] = this.quantity;
    return data;
  }
}