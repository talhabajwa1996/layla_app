class VariantOptionModel {
  VariantOption? variantOption;

  VariantOptionModel({this.variantOption});

  VariantOptionModel.fromJson(Map<String, dynamic> json) {
    variantOption = json['variantOption'] != null
        ? new VariantOption.fromJson(json['variantOption'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.variantOption != null) {
      data['variantOption'] = this.variantOption!.toJson();
    }
    return data;
  }
}

class VariantOption {
  String? name;
  String? value;

  VariantOption({this.name, this.value});

  VariantOption.fromJson(Map<String, dynamic> json) {
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
