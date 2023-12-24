class UpdateCartLinesResponseModel {
  CartLinesUpdate? cartLinesUpdate;

  UpdateCartLinesResponseModel({this.cartLinesUpdate});

  UpdateCartLinesResponseModel.fromJson(Map<String, dynamic> json) {
    cartLinesUpdate = json['cartLinesUpdate'] != null
        ? new CartLinesUpdate.fromJson(json['cartLinesUpdate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartLinesUpdate != null) {
      data['cartLinesUpdate'] = this.cartLinesUpdate!.toJson();
    }
    return data;
  }
}

class CartLinesUpdate {
  Cart? cart;
  List<UserErrors>? userErrors;

  CartLinesUpdate({this.cart, this.userErrors});

  CartLinesUpdate.fromJson(Map<String, dynamic> json) {
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
  String? id;
  Lines? lines;
  Cost? cost;

  Cart({this.id, this.lines, this.cost});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lines = json['lines'] != null ? new Lines.fromJson(json['lines']) : null;
    cost = json['cost'] != null ? new Cost.fromJson(json['cost']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
  List<Edges>? edges;

  Lines({this.edges});

  Lines.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edges = <Edges>[];
      json['edges'].forEach((v) {
        edges!.add(new Edges.fromJson(v));
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

class Edges {
  Node? node;

  Edges({this.node});

  Edges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? new Node.fromJson(json['node']) : null;
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
  String? id;
  int? quantity;
  Merchandise? merchandise;

  Node({this.id, this.quantity, this.merchandise});

  Node.fromJson(Map<String, dynamic> json) {
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

  Merchandise({this.id});

  Merchandise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Cost {
  TotalAmount? totalAmount;
  TotalAmount? subtotalAmount;
  Null? totalTaxAmount;
  Null? totalDutyAmount;

  Cost(
      {this.totalAmount,
        this.subtotalAmount,
        this.totalTaxAmount,
        this.totalDutyAmount});

  Cost.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'] != null
        ? new TotalAmount.fromJson(json['totalAmount'])
        : null;
    subtotalAmount = json['subtotalAmount'] != null
        ? new TotalAmount.fromJson(json['subtotalAmount'])
        : null;
    totalTaxAmount = json['totalTaxAmount'];
    totalDutyAmount = json['totalDutyAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.totalAmount != null) {
      data['totalAmount'] = this.totalAmount!.toJson();
    }
    if (this.subtotalAmount != null) {
      data['subtotalAmount'] = this.subtotalAmount!.toJson();
    }
    data['totalTaxAmount'] = this.totalTaxAmount;
    data['totalDutyAmount'] = this.totalDutyAmount;
    return data;
  }
}

class TotalAmount {
  String? amount;
  String? currencyCode;

  TotalAmount({this.amount, this.currencyCode});

  TotalAmount.fromJson(Map<String, dynamic> json) {
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