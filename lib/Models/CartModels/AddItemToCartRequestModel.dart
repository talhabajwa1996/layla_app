class AddItemToCartRequestModel {
  String? cartId;
  List<LinesAddItemToCart>? lines;

  AddItemToCartRequestModel({this.cartId, this.lines});

  AddItemToCartRequestModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    if (json['lines'] != null) {
      lines = <LinesAddItemToCart>[];
      json['lines'].forEach((v) {
        lines!.add(new LinesAddItemToCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LinesAddItemToCart {
  String? merchandiseId;
  int? quantity;

  LinesAddItemToCart({this.merchandiseId, this.quantity});

  LinesAddItemToCart.fromJson(Map<String, dynamic> json) {
    merchandiseId = json['merchandiseId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchandiseId'] = this.merchandiseId;
    data['quantity'] = this.quantity;
    return data;
  }
}