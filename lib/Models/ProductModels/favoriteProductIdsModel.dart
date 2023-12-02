class FavoriteProductIdsModel {
  List<String>? productIds;

  FavoriteProductIdsModel({this.productIds});

  FavoriteProductIdsModel.fromJson(Map<String, dynamic> json) {
    productIds = json['productIds'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productIds'] = this.productIds;
    return data;
  }
}