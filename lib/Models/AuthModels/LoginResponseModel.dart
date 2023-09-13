class LoginResponseModel {
  CustomerAccessTokenCreate? customerAccessTokenCreate;

  LoginResponseModel({this.customerAccessTokenCreate});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    customerAccessTokenCreate = json['customerAccessTokenCreate'] != null
        ? new CustomerAccessTokenCreate.fromJson(
        json['customerAccessTokenCreate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerAccessTokenCreate != null) {
      data['customerAccessTokenCreate'] =
          this.customerAccessTokenCreate!.toJson();
    }
    return data;
  }
}

class CustomerAccessTokenCreate {
  CustomerAccessToken? customerAccessToken;
  List<CustomerUserErrors>? customerUserErrors;

  CustomerAccessTokenCreate(
      {this.customerAccessToken, this.customerUserErrors});

  CustomerAccessTokenCreate.fromJson(Map<String, dynamic> json) {
    customerAccessToken = json['customerAccessToken'] != null
        ? new CustomerAccessToken.fromJson(json['customerAccessToken'])
        : null;
    if (json['customerUserErrors'] != null) {
      customerUserErrors = <CustomerUserErrors>[];
      json['customerUserErrors'].forEach((v) {
        customerUserErrors!.add(new CustomerUserErrors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerAccessToken != null) {
      data['customerAccessToken'] = this.customerAccessToken!.toJson();
    }
    if (this.customerUserErrors != null) {
      data['customerUserErrors'] =
          this.customerUserErrors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerAccessToken {
  String? accessToken;
  String? expiresAt;

  CustomerAccessToken({this.accessToken, this.expiresAt});

  CustomerAccessToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['expiresAt'] = this.expiresAt;
    return data;
  }
}

class CustomerUserErrors {
  String? code;
  String? message;

  CustomerUserErrors({this.code, this.message});

  CustomerUserErrors.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}