class ReturnableFulfillmentResponseModel {
  Data? data;
  Extensions? extensions;

  ReturnableFulfillmentResponseModel({this.data, this.extensions});

  ReturnableFulfillmentResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    extensions = json['extensions'] != null
        ? new Extensions.fromJson(json['extensions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.extensions != null) {
      data['extensions'] = this.extensions!.toJson();
    }
    return data;
  }
}

class Data {
  ReturnableFulfillments? returnableFulfillments;

  Data({this.returnableFulfillments});

  Data.fromJson(Map<String, dynamic> json) {
    returnableFulfillments = json['returnableFulfillments'] != null
        ? new ReturnableFulfillments.fromJson(json['returnableFulfillments'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.returnableFulfillments != null) {
      data['returnableFulfillments'] = this.returnableFulfillments!.toJson();
    }
    return data;
  }
}

class ReturnableFulfillments {
  List<ReturnableEdges>? edges;

  ReturnableFulfillments({this.edges});

  ReturnableFulfillments.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edges = <ReturnableEdges>[];
      json['edges'].forEach((v) {
        edges!.add(new ReturnableEdges.fromJson(v));
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

class ReturnableEdges {
  ReturnableNode? node;

  ReturnableEdges({this.node});

  ReturnableEdges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? new ReturnableNode.fromJson(json['node']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.node != null) {
      data['node'] = this.node!.toJson();
    }
    return data;
  }
}

class ReturnableNode {
  String? id;
  Fulfillment? fulfillment;
  ReturnableFulfillmentLineItems? returnableFulfillmentLineItems;

  ReturnableNode({this.id, this.fulfillment, this.returnableFulfillmentLineItems});

  ReturnableNode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fulfillment = json['fulfillment'] != null
        ? new Fulfillment.fromJson(json['fulfillment'])
        : null;
    returnableFulfillmentLineItems =
    json['returnableFulfillmentLineItems'] != null
        ? new ReturnableFulfillmentLineItems.fromJson(
        json['returnableFulfillmentLineItems'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.fulfillment != null) {
      data['fulfillment'] = this.fulfillment!.toJson();
    }
    if (this.returnableFulfillmentLineItems != null) {
      data['returnableFulfillmentLineItems'] =
          this.returnableFulfillmentLineItems!.toJson();
    }
    return data;
  }
}

class Fulfillment {
  String? id;

  Fulfillment({this.id});

  Fulfillment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class ReturnableFulfillmentLineItems {
  List<FulfillmentLineItemsEdges>? edges;

  ReturnableFulfillmentLineItems({this.edges});

  ReturnableFulfillmentLineItems.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edges = <FulfillmentLineItemsEdges>[];
      json['edges'].forEach((v) {
        edges!.add(new FulfillmentLineItemsEdges.fromJson(v));
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

class FulfillmentLineItemsEdges {
  FulfillmentLineItemsNode? node;

  FulfillmentLineItemsEdges({this.node});

  FulfillmentLineItemsEdges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? new FulfillmentLineItemsNode.fromJson(json['node']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.node != null) {
      data['node'] = this.node!.toJson();
    }
    return data;
  }
}

class FulfillmentLineItemsNode {
  FulfillmentLineItem? fulfillmentLineItem;
  int? quantity;

  FulfillmentLineItemsNode({this.fulfillmentLineItem, this.quantity});

  FulfillmentLineItemsNode.fromJson(Map<String, dynamic> json) {
    fulfillmentLineItem = json['fulfillmentLineItem'] != null
        ? new FulfillmentLineItem.fromJson(json['fulfillmentLineItem'])
        : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fulfillmentLineItem != null) {
      data['fulfillmentLineItem'] = this.fulfillmentLineItem!.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}

class FulfillmentLineItem {
  String? id;
  LineItem? lineItem;

  FulfillmentLineItem({this.id, this.lineItem});

  FulfillmentLineItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lineItem = json['lineItem'] != null
        ? new LineItem.fromJson(json['lineItem'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.lineItem != null) {
      data['lineItem'] = this.lineItem!.toJson();
    }
    return data;
  }
}

class LineItem {
  int? currentQuantity;
  // List<dynamic>? discountAllocations;
  String? discountedTotal;
  String? originalTotal;
  int? quantity;
  String? title;
  Image? image;
  Variant? variant;

  LineItem(
      {this.currentQuantity,
        // this.discountAllocations,
        this.discountedTotal,
        this.originalTotal,
        this.quantity,
        this.title,
        this.variant});

  LineItem.fromJson(Map<String, dynamic> json) {
    currentQuantity = json['currentQuantity'];
    // if (json['discountAllocations'] != null) {
    //   discountAllocations = <Null>[];
    //   json['discountAllocations'].forEach((v) {
    //     discountAllocations!.add(new List<dynamic>.fromJson(v));
    //   });
    // }
    discountedTotal = json['discountedTotal'];
    originalTotal = json['originalTotal'];
    quantity = json['quantity'];
    title = json['title'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
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
    data['discountedTotal'] = this.discountedTotal;
    data['originalTotal'] = this.originalTotal;
    data['quantity'] = this.quantity;
    data['title'] = this.title;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.variant != null) {
      data['variant'] = this.variant!.toJson();
    }
    return data;
  }
}

class Variant {
  String? price;
  String? title;
  Image? image;
  String? compareAtPrice;
  double? weight;
  String? weightUnit;
  bool? availableForSale;
  String? sku;
  bool? requiresShipping;
  String? id;

  Variant(
      {this.price,
        this.title,
        this.image,
        this.compareAtPrice,
        this.weight,
        this.weightUnit,
        this.availableForSale,
        this.sku,
        this.requiresShipping,
        this.id});

  Variant.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    title = json['title'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    compareAtPrice = json['compareAtPrice'];
    weight = json['weight'];
    weightUnit = json['weightUnit'];
    availableForSale = json['availableForSale'];
    sku = json['sku'];
    requiresShipping = json['requiresShipping'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['title'] = this.title;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['compareAtPrice'] = this.compareAtPrice;
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
  dynamic altText;
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

class Extensions {
  Cost? cost;

  Extensions({this.cost});

  Extensions.fromJson(Map<String, dynamic> json) {
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
  int? requestedQueryCost;
  int? actualQueryCost;
  ThrottleStatus? throttleStatus;

  Cost({this.requestedQueryCost, this.actualQueryCost, this.throttleStatus});

  Cost.fromJson(Map<String, dynamic> json) {
    requestedQueryCost = json['requestedQueryCost'];
    actualQueryCost = json['actualQueryCost'];
    throttleStatus = json['throttleStatus'] != null
        ? new ThrottleStatus.fromJson(json['throttleStatus'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestedQueryCost'] = this.requestedQueryCost;
    data['actualQueryCost'] = this.actualQueryCost;
    if (this.throttleStatus != null) {
      data['throttleStatus'] = this.throttleStatus!.toJson();
    }
    return data;
  }
}

class ThrottleStatus {
  int? maximumAvailable;
  int? currentlyAvailable;
  int? restoreRate;

  ThrottleStatus(
      {this.maximumAvailable, this.currentlyAvailable, this.restoreRate});

  ThrottleStatus.fromJson(Map<String, dynamic> json) {
    maximumAvailable = json['maximumAvailable'];
    currentlyAvailable = json['currentlyAvailable'];
    restoreRate = json['restoreRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maximumAvailable'] = this.maximumAvailable;
    data['currentlyAvailable'] = this.currentlyAvailable;
    data['restoreRate'] = this.restoreRate;
    return data;
  }
}
