class CreateAccountRequestModel {
  Input? input;

  CreateAccountRequestModel({this.input});

  CreateAccountRequestModel.fromJson(Map<String, dynamic> json) {
    input = json['input'] != null ? new Input.fromJson(json['input']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.input != null) {
      data['input'] = this.input!.toJson();
    }
    return data;
  }
}

class Input {
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  bool? acceptsMarketing;

  Input(
      {this.email,
        this.password,
        this.firstName,
        this.lastName,
        this.acceptsMarketing});

  Input.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    acceptsMarketing = json['acceptsMarketing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['acceptsMarketing'] = this.acceptsMarketing;
    return data;
  }
}