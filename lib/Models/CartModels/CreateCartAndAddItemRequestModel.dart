class CreateCartAndAddItemRequestModel {
  String? merchandiseId;
  int? quantity;

  CreateCartAndAddItemRequestModel({this.merchandiseId, this.quantity});

  CreateCartAndAddItemRequestModel.fromJson(Map<String, dynamic> json) {
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