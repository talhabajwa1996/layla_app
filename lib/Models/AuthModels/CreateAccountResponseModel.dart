class CreateAccountResponseModel {
  CustomerCreate? customerCreate;

  CreateAccountResponseModel({this.customerCreate});

  CreateAccountResponseModel.fromJson(Map<String, dynamic> json) {
    customerCreate = json['customerCreate'] != null
        ? new CustomerCreate.fromJson(json['customerCreate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerCreate != null) {
      data['customerCreate'] = this.customerCreate!.toJson();
    }
    return data;
  }
}

class CustomerCreate {
  List<CustomerUserErrors>? customerUserErrors;
  Customer? customer;

  CustomerCreate({this.customerUserErrors, this.customer});

  CustomerCreate.fromJson(Map<String, dynamic> json) {
    if (json['customerUserErrors'] != null) {
      customerUserErrors = <CustomerUserErrors>[];
      json['customerUserErrors'].forEach((v) {
        customerUserErrors!.add(new CustomerUserErrors.fromJson(v));
      });
    }
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerUserErrors != null) {
      data['customerUserErrors'] =
          this.customerUserErrors!.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class CustomerUserErrors {
  String? code;
  List<String>? field;
  String? message;

  CustomerUserErrors({this.code, this.field, this.message});

  CustomerUserErrors.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    field = json['field'].cast<String>();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['field'] = this.field;
    data['message'] = this.message;
    return data;
  }
}

class Customer {
  String? id;
  String? firstName;
  String? lastName;
  String? email;

  Customer({this.id, this.firstName, this.lastName, this.email});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    return data;
  }
}