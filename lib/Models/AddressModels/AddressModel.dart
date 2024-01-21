class AddressModel {
  String? firstName;
  String? lastName;
  String? address;
  String? city;
  String? province;
  String? country;
  String? postalCode;

  AddressModel(
      {this.firstName,
        this.lastName,
        this.address,
        this.city,
        this.province,
        this.country,
        this.postalCode});

  AddressModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    city = json['city'];
    province = json['province'];
    country = json['country'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address'] = this.address;
    data['city'] = this.city;
    data['province'] = this.province;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    return data;
  }
}