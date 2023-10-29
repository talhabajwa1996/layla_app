class MenuCollectionsResponseModel {
  Menu? menu;

  MenuCollectionsResponseModel({this.menu});

  MenuCollectionsResponseModel.fromJson(Map<String, dynamic> json) {
    menu = json['menu'] != null ? new Menu.fromJson(json['menu']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.menu != null) {
      data['menu'] = this.menu!.toJson();
    }
    return data;
  }
}

class Menu {
  List<Items>? items;
  String? handle;
  String? title;

  Menu({this.items, this.handle, this.title});

  Menu.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    handle = json['handle'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['handle'] = this.handle;
    data['title'] = this.title;
    return data;
  }
}

class Items {
  String? title;
  String? type;
  String? url;
  String? id;
  List<SubCollectionItems>? subCollectionItems;

  Items({this.title, this.type, this.url, this.id, this.subCollectionItems});

  Items.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    url = json['url'];
    id = json['id'];
    if (json['items'] != null) {
      subCollectionItems = <SubCollectionItems>[];
      json['items'].forEach((v) {
        subCollectionItems!.add(new SubCollectionItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['id'] = this.id;
    if (this.subCollectionItems != null) {
      data['items'] = this.subCollectionItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCollectionItems {
  String? id;
  String? title;
  String? url;
  String? type;

  SubCollectionItems({this.id, this.title, this.url, this.type});

  SubCollectionItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}