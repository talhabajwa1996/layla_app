class RetrieveCartRequestModel {
  String? cartId;

  RetrieveCartRequestModel({this.cartId});

  RetrieveCartRequestModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    return data;
  }
}