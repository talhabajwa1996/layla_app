class CustomerOrdersResponseModel {
  CustomerData? data;

  CustomerOrdersResponseModel({this.data});

  CustomerOrdersResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CustomerData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CustomerData {
  Customer? customer;

  CustomerData({this.customer});

  CustomerData.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Customer {
  Orders? orders;
  String? id;

  Customer({this.orders, this.id});

  Customer.fromJson(Map<String, dynamic> json) {
    orders =
    json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Orders {
  List<OrderEdges>? edges;

  Orders({this.edges});

  Orders.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edges = <OrderEdges>[];
      json['edges'].forEach((v) {
        edges!.add(new OrderEdges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.edges != null) {
      data['edges'] = this.edges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderEdges {
  OrderNode? node;
  String? cursor;

  OrderEdges({this.node, this.cursor});

  OrderEdges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? new OrderNode.fromJson(json['node']) : null;
    cursor = json['cursor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.node != null) {
      data['node'] = this.node!.toJson();
    }
    data['cursor'] = this.cursor;
    return data;
  }
}

class OrderNode {
  String? id;
  String? email;
  String? currencyCode;
  String? customerUrl;
  String? financialStatus;
  String? fulfillmentStatus;
  Orders? lineItems;
  // List<SuccessfulFulfillments>? successfulFulfillments;
  String? name;
  int? orderNumber;
  dynamic phone;
  String? processedAt;
  ShippingAddress? shippingAddress;
  ShippingAddress? billingAddress;
  String? statusUrl;
  DiscountedTotalPrice? subtotalPriceV2;
  DiscountedTotalPrice? totalPriceV2;
  DiscountedTotalPrice? totalRefundedV2;
  DiscountedTotalPrice? totalShippingPriceV2;
  DiscountedTotalPrice? totalTaxV2;

  OrderNode(
      {this.id,
        this.email,
        this.currencyCode,
        this.customerUrl,
        this.financialStatus,
        this.fulfillmentStatus,
        this.lineItems,
        // this.successfulFulfillments,
        this.name,
        this.orderNumber,
        this.phone,
        this.processedAt,
        this.shippingAddress,
        this.billingAddress,
        this.statusUrl,
        this.subtotalPriceV2,
        this.totalPriceV2,
        this.totalRefundedV2,
        this.totalShippingPriceV2,
        this.totalTaxV2});

  OrderNode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    currencyCode = json['currencyCode'];
    customerUrl = json['customerUrl'];
    financialStatus = json['financialStatus'];
    fulfillmentStatus = json['fulfillmentStatus'];
    lineItems = json['lineItems'] != null
        ? new Orders.fromJson(json['lineItems'])
        : null;
    // if (json['successfulFulfillments'] != null) {
    //   successfulFulfillments = <SuccessfulFulfillments>[];
    //   json['successfulFulfillments'].forEach((v) {
    //     successfulFulfillments!.add(new SuccessfulFulfillments.fromJson(v));
    //   });
    // }
    name = json['name'];
    orderNumber = json['orderNumber'];
    phone = json['phone'];
    processedAt = json['processedAt'];
    shippingAddress = json['shippingAddress'] != null
        ? new ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    billingAddress = json['billingAddress'] != null
        ? new ShippingAddress.fromJson(json['billingAddress'])
        : null;
    statusUrl = json['statusUrl'];
    subtotalPriceV2 = json['subtotalPriceV2'] != null
        ? new DiscountedTotalPrice.fromJson(json['subtotalPriceV2'])
        : null;
    totalPriceV2 = json['totalPriceV2'] != null
        ? new DiscountedTotalPrice.fromJson(json['totalPriceV2'])
        : null;
    totalRefundedV2 = json['totalRefundedV2'] != null
        ? new DiscountedTotalPrice.fromJson(json['totalRefundedV2'])
        : null;
    totalShippingPriceV2 = json['totalShippingPriceV2'] != null
        ? new DiscountedTotalPrice.fromJson(json['totalShippingPriceV2'])
        : null;
    totalTaxV2 = json['totalTaxV2'] != null
        ? new DiscountedTotalPrice.fromJson(json['totalTaxV2'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['currencyCode'] = this.currencyCode;
    data['customerUrl'] = this.customerUrl;
    data['financialStatus'] = this.financialStatus;
    data['fulfillmentStatus'] = this.fulfillmentStatus;
    if (this.lineItems != null) {
      data['lineItems'] = this.lineItems!.toJson();
    }
    // if (this.successfulFulfillments != null) {
    //   data['successfulFulfillments'] =
    //       this.successfulFulfillments!.map((v) => v.toJson()).toList();
    // }
    data['name'] = this.name;
    data['orderNumber'] = this.orderNumber;
    data['phone'] = this.phone;
    data['processedAt'] = this.processedAt;
    if (this.shippingAddress != null) {
      data['shippingAddress'] = this.shippingAddress!.toJson();
    }
    if (this.billingAddress != null) {
      data['billingAddress'] = this.billingAddress!.toJson();
    }
    data['statusUrl'] = this.statusUrl;
    if (this.subtotalPriceV2 != null) {
      data['subtotalPriceV2'] = this.subtotalPriceV2!.toJson();
    }
    if (this.totalPriceV2 != null) {
      data['totalPriceV2'] = this.totalPriceV2!.toJson();
    }
    if (this.totalRefundedV2 != null) {
      data['totalRefundedV2'] = this.totalRefundedV2!.toJson();
    }
    if (this.totalShippingPriceV2 != null) {
      data['totalShippingPriceV2'] = this.totalShippingPriceV2!.toJson();
    }
    if (this.totalTaxV2 != null) {
      data['totalTaxV2'] = this.totalTaxV2!.toJson();
    }
    return data;
  }
}

class Edges {
  OrderNode? node;

  Edges({this.node});

  Edges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? new OrderNode.fromJson(json['node']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.node != null) {
      data['node'] = this.node!.toJson();
    }
    return data;
  }
}

class Node {
  int? currentQuantity;
  // List<Null>? discountAllocations;
  DiscountedTotalPrice? discountedTotalPrice;
  DiscountedTotalPrice? originalTotalPrice;
  int? quantity;
  String? title;
  Variant? variant;

  Node(
      {this.currentQuantity,
        // this.discountAllocations,
        this.discountedTotalPrice,
        this.originalTotalPrice,
        this.quantity,
        this.title,
        this.variant});

  Node.fromJson(Map<String, dynamic> json) {
    currentQuantity = json['currentQuantity'];
    // if (json['discountAllocations'] != null) {
    //   discountAllocations = <Null>[];
    //   json['discountAllocations'].forEach((v) {
    //     discountAllocations!.add(new Null.fromJson(v));
    //   });
    // }
    discountedTotalPrice = json['discountedTotalPrice'] != null
        ? new DiscountedTotalPrice.fromJson(json['discountedTotalPrice'])
        : null;
    originalTotalPrice = json['originalTotalPrice'] != null
        ? new DiscountedTotalPrice.fromJson(json['originalTotalPrice'])
        : null;
    quantity = json['quantity'];
    title = json['title'];
    variant =
    json['variant'] != null ? new Variant.fromJson(json['variant']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentQuantity'] = this.currentQuantity;
    // if (this.discountAllocations != null) {
    //   data['discountAllocations'] =
    //       this.discountAllocations!.map((v) => v.toJson()).toList();
    // }
    if (this.discountedTotalPrice != null) {
      data['discountedTotalPrice'] = this.discountedTotalPrice!.toJson();
    }
    if (this.originalTotalPrice != null) {
      data['originalTotalPrice'] = this.originalTotalPrice!.toJson();
    }
    data['quantity'] = this.quantity;
    data['title'] = this.title;
    if (this.variant != null) {
      data['variant'] = this.variant!.toJson();
    }
    return data;
  }
}

class DiscountedTotalPrice {
  String? amount;
  String? currencyCode;

  DiscountedTotalPrice({this.amount, this.currencyCode});

  DiscountedTotalPrice.fromJson(Map<String, dynamic> json) {
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

class Variant {
  DiscountedTotalPrice? priceV2;
  String? title;
  Image? image;
  String? compareAtPriceV2;
  double? weight;
  String? weightUnit;
  bool? availableForSale;
  String? sku;
  bool? requiresShipping;
  String? id;

  Variant(
      {this.priceV2,
        this.title,
        this.image,
        this.compareAtPriceV2,
        this.weight,
        this.weightUnit,
        this.availableForSale,
        this.sku,
        this.requiresShipping,
        this.id});

  Variant.fromJson(Map<String, dynamic> json) {
    priceV2 = json['priceV2'] != null
        ? new DiscountedTotalPrice.fromJson(json['priceV2'])
        : null;
    title = json['title'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    compareAtPriceV2 = json['compareAtPriceV2'];
    weight = json['weight'];
    weightUnit = json['weightUnit'];
    availableForSale = json['availableForSale'];
    sku = json['sku'];
    requiresShipping = json['requiresShipping'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.priceV2 != null) {
      data['priceV2'] = this.priceV2!.toJson();
    }
    data['title'] = this.title;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['compareAtPriceV2'] = this.compareAtPriceV2;
    data['weight'] = this.weight;
    data['weightUnit'] = this.weightUnit;
    data['availableForSale'] = this.availableForSale;
    data['sku'] = this.sku;
    data['requiresShipping'] = this.requiresShipping;
    data['id'] = this.id;
    return data;
  }
}

class Image {
  String? altText;
  String? id;
  String? originalSrc;

  Image({this.altText, this.id, this.originalSrc});

  Image.fromJson(Map<String, dynamic> json) {
    altText = json['altText'];
    id = json['id'];
    originalSrc = json['originalSrc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['altText'] = this.altText;
    data['id'] = this.id;
    data['originalSrc'] = this.originalSrc;
    return data;
  }
}

// class SuccessfulFulfillments {
//   dynamic trackingCompany;
//   List<dynamic>? trackingInfo;
//
//   SuccessfulFulfillments({this.trackingCompany, this.trackingInfo});
//
//   SuccessfulFulfillments.fromJson(Map<String, dynamic> json) {
//     trackingCompany = json['trackingCompany'];
//     if (json['trackingInfo'] != null) {
//       trackingInfo = <Null>[];
//       json['trackingInfo'].forEach((v) {
//         trackingInfo!.add(new Null.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['trackingCompany'] = this.trackingCompany;
//     if (this.trackingInfo != null) {
//       data['trackingInfo'] = this.trackingInfo!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class ShippingAddress {
  String? address1;
  String? address2;
  String? city;
  String? company;
  String? country;
  String? countryCodeV2;
  String? firstName;
  String? id;
  String? lastName;
  String? latitude;
  String? longitude;
  String? name;
  String? phone;
  String? province;
  String? provinceCode;
  String? zip;

  ShippingAddress(
      {this.address1,
        this.address2,
        this.city,
        this.company,
        this.country,
        this.countryCodeV2,
        this.firstName,
        this.id,
        this.lastName,
        this.latitude,
        this.longitude,
        this.name,
        this.phone,
        this.province,
        this.provinceCode,
        this.zip});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    company = json['company'];
    country = json['country'];
    countryCodeV2 = json['countryCodeV2'];
    firstName = json['firstName'];
    id = json['id'];
    lastName = json['lastName'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    phone = json['phone'];
    province = json['province'];
    provinceCode = json['provinceCode'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['company'] = this.company;
    data['country'] = this.country;
    data['countryCodeV2'] = this.countryCodeV2;
    data['firstName'] = this.firstName;
    data['id'] = this.id;
    data['lastName'] = this.lastName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['province'] = this.province;
    data['provinceCode'] = this.provinceCode;
    data['zip'] = this.zip;
    return data;
  }
}
