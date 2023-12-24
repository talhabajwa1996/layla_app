class RetrieveCartResponseModel {
  Cart? cart;

  RetrieveCartResponseModel({this.cart});

  RetrieveCartResponseModel.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.toJson();
    }
    return data;
  }
}

class Cart {
  String? id;
  String? createdAt;
  String? updatedAt;
  Lines? lines;
  Cost? cost;

  Cart({this.id, this.createdAt, this.updatedAt, this.lines, this.cost});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    lines = json['lines'] != null ? new Lines.fromJson(json['lines']) : null;
    cost = json['cost'] != null ? new Cost.fromJson(json['cost']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.lines != null) {
      data['lines'] = this.lines!.toJson();
    }
    if (this.cost != null) {
      data['cost'] = this.cost!.toJson();
    }
    return data;
  }
}

class Lines {
  List<Nodes>? nodes;

  Lines({this.nodes});

  Lines.fromJson(Map<String, dynamic> json) {
    if (json['nodes'] != null) {
      nodes = <Nodes>[];
      json['nodes'].forEach((v) {
        nodes!.add(new Nodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nodes != null) {
      data['nodes'] = this.nodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nodes {
  String? id;
  int? quantity;
  Merchandise? merchandise;

  Nodes({this.id, this.quantity, this.merchandise});

  Nodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    merchandise = json['merchandise'] != null
        ? new Merchandise.fromJson(json['merchandise'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    if (this.merchandise != null) {
      data['merchandise'] = this.merchandise!.toJson();
    }
    return data;
  }
}

class Merchandise {
  String? id;
  String? title;
  Product? product;
  Price? price;
  Image? image;
  List<SelectedOptions>? selectedOptions;

  Merchandise(
      {this.id,
        this.title,
        this.product,
        this.price,
        this.image,
        this.selectedOptions});

  Merchandise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    if (json['selectedOptions'] != null) {
      selectedOptions = <SelectedOptions>[];
      json['selectedOptions'].forEach((v) {
        selectedOptions!.add(new SelectedOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.selectedOptions != null) {
      data['selectedOptions'] =
          this.selectedOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? title;
  String? description;
  String? id;

  Product({this.title, this.description, this.id});

  Product.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['id'] = this.id;
    return data;
  }
}

class Price {
  String? amount;
  String? currencyCode;

  Price({this.amount, this.currencyCode});

  Price.fromJson(Map<String, dynamic> json) {
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

class Image {
  String? url;

  Image({this.url});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class SelectedOptions {
  String? name;
  String? value;

  SelectedOptions({this.name, this.value});

  SelectedOptions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class Cost {
  Price? totalAmount;
  Price? subtotalAmount;
  Price? totalTaxAmount;
  Price? totalDutyAmount;

  Cost(
      {this.totalAmount,
        this.subtotalAmount,
        this.totalTaxAmount,
        this.totalDutyAmount});

  Cost.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'] != null
        ? new Price.fromJson(json['totalAmount'])
        : null;
    subtotalAmount = json['subtotalAmount'] != null
        ? new Price.fromJson(json['subtotalAmount'])
        : null;
    totalTaxAmount = json['totalTaxAmount'] != null
        ? new Price.fromJson(json['totalTaxAmount'])
        : null;
    totalDutyAmount = json['totalDutyAmount'] != null
        ? new Price.fromJson(json['totalDutyAmount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.totalAmount != null) {
      data['totalAmount'] = this.totalAmount!.toJson();
    }
    if (this.subtotalAmount != null) {
      data['subtotalAmount'] = this.subtotalAmount!.toJson();
    }
    if (this.totalTaxAmount != null) {
      data['totalTaxAmount'] = this.totalTaxAmount!.toJson();
    }
    if (this.totalDutyAmount != null) {
      data['totalDutyAmount'] = this.totalDutyAmount!.toJson();
    }
    return data;
  }
}