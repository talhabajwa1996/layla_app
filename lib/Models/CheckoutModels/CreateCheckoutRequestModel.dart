class CreateCheckoutRequestModel {
  List<LineItems>? lineItems;
  ShippingAddress? shippingAddress;

  CreateCheckoutRequestModel({this.lineItems, this.shippingAddress});

  CreateCheckoutRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['lineItems'] != null) {
      lineItems = <LineItems>[];
      json['lineItems'].forEach((v) {
        lineItems!.add(new LineItems.fromJson(v));
      });
    }
    shippingAddress = json['shippingAddress'] != null
        ? new ShippingAddress.fromJson(json['shippingAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lineItems != null) {
      data['lineItems'] = this.lineItems!.map((v) => v.toJson()).toList();
    }
    if (this.shippingAddress != null) {
      data['shippingAddress'] = this.shippingAddress!.toJson();
    }
    return data;
  }
}

class LineItems {
  String? variantId;
  int? quantity;

  LineItems({this.variantId, this.quantity});

  LineItems.fromJson(Map<String, dynamic> json) {
    variantId = json['variantId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variantId'] = this.variantId;
    data['quantity'] = this.quantity;
    return data;
  }
}

class ShippingAddress {
  String? address1;
  String? city;
  String? province;
  String? country;
  String? firstName;
  String? lastName;
  String? zip;

  ShippingAddress(
      {this.address1,
        this.city,
        this.province,
        this.country,
        this.firstName,
        this.lastName,
        this.zip});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    city = json['city'];
    province = json['province'];
    country = json['country'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address1'] = this.address1;
    data['city'] = this.city;
    data['province'] = this.province;
    data['country'] = this.country;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['zip'] = this.zip;
    return data;
  }
}