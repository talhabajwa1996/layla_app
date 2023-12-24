class UpdateCartLinesRequestModel {
  String? cartId;
  List<LinesUpdate>? lines;

  UpdateCartLinesRequestModel({this.cartId, this.lines});

  UpdateCartLinesRequestModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    if (json['lines'] != null) {
      lines = <LinesUpdate>[];
      json['lines'].forEach((v) {
        lines!.add(new LinesUpdate.fromJson(v));
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

class LinesUpdate {
  String? id;
  int? quantity;

  LinesUpdate({this.id, this.quantity});

  LinesUpdate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    return data;
  }
}