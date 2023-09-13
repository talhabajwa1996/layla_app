class SendPasswordResetResponseModel {
  CustomerRecover? customerRecover;

  SendPasswordResetResponseModel({this.customerRecover});

  SendPasswordResetResponseModel.fromJson(Map<String, dynamic> json) {
    customerRecover = json['customerRecover'] != null
        ? new CustomerRecover.fromJson(json['customerRecover'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerRecover != null) {
      data['customerRecover'] = this.customerRecover!.toJson();
    }
    return data;
  }
}

class CustomerRecover {
  List<CustomerUserErrors>? customerUserErrors;
  List<UserErrors>? userErrors;

  CustomerRecover({this.customerUserErrors, this.userErrors});

  CustomerRecover.fromJson(Map<String, dynamic> json) {
    if (json['customerUserErrors'] != null) {
      customerUserErrors = <CustomerUserErrors>[];
      json['customerUserErrors'].forEach((v) {
        customerUserErrors!.add(new CustomerUserErrors.fromJson(v));
      });
    }
    if (json['userErrors'] != null) {
      userErrors = <UserErrors>[];
      json['userErrors'].forEach((v) {
        userErrors!.add(new UserErrors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerUserErrors != null) {
      data['customerUserErrors'] =
          this.customerUserErrors!.map((v) => v.toJson()).toList();
    }
    if (this.userErrors != null) {
      data['userErrors'] = this.userErrors!.map((v) => v.toJson()).toList();
    }
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

class UserErrors {
  String? message;

  UserErrors({this.message});

  UserErrors.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}