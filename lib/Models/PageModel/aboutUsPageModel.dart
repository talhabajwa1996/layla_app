class AboutUsPageModel {
  AboutUsData? data;

  AboutUsPageModel({this.data});

  AboutUsPageModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AboutUsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AboutUsData {
  AboutUsPage? page;

  AboutUsData({this.page});

  AboutUsData.fromJson(Map<String, dynamic> json) {
    page = json['page'] != null ? new AboutUsPage.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.page != null) {
      data['page'] = this.page!.toJson();
    }
    return data;
  }
}

class AboutUsPage {
  String? handle;
  String? id;
  String? title;
  String? body;
  String? bodySummary;
  String? createdAt;
  String? onlineStoreUrl;

  AboutUsPage(
      {this.handle,
        this.id,
        this.title,
        this.body,
        this.bodySummary,
        this.createdAt,
        this.onlineStoreUrl});

  AboutUsPage.fromJson(Map<String, dynamic> json) {
    handle = json['handle'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
    bodySummary = json['bodySummary'];
    createdAt = json['createdAt'];
    onlineStoreUrl = json['onlineStoreUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['handle'] = this.handle;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['bodySummary'] = this.bodySummary;
    data['createdAt'] = this.createdAt;
    data['onlineStoreUrl'] = this.onlineStoreUrl;
    return data;
  }
}
