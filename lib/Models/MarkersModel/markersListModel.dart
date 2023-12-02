class MarkersListModel {
  List<ShopLocationData>? marker;

  MarkersListModel({this.marker});

  MarkersListModel.fromJson(Map<String, dynamic> json) {
    if (json['marker'] != null) {
      marker = <ShopLocationData>[];
      json['marker'].forEach((v) {
        marker!.add(new ShopLocationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.marker != null) {
      data['marker'] = this.marker!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopLocationData {
  String? name;
  String? lng;
  String? lat;
  String? category;
  String? address;
  String? address2;
  String? city;
  String? state;
  String? postal;
  String? country;
  String? phone;
  String? email;
  String? web;
  String? hours1;
  String? hours2;
  String? hours3;
  String? featured;
  String? features;

  ShopLocationData(
      {this.name,
      this.lng,
      this.lat,
      this.category,
      this.address,
      this.address2,
      this.city,
      this.state,
      this.postal,
      this.country,
      this.phone,
      this.email,
      this.web,
      this.hours1,
      this.hours2,
      this.hours3,
      this.featured,
      this.features});

  ShopLocationData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lng = json['lng'];
    lat = json['lat'];
    category = json['category'];
    address = json['address'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    postal = json['postal'];
    country = json['country'];
    phone = json['phone'];
    email = json['email'];
    web = json['web'];
    hours1 = json['hours1'];
    hours2 = json['hours2'];
    hours3 = json['hours3'];
    featured = json['featured'];
    features = json['features'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['category'] = this.category;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postal'] = this.postal;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['web'] = this.web;
    data['hours1'] = this.hours1;
    data['hours2'] = this.hours2;
    data['hours3'] = this.hours3;
    data['featured'] = this.featured;
    data['features'] = this.features;
    return data;
  }
}

final Map<String, dynamic> markersJson = {
  "marker": [
    {
      "name": "The Gate Mall",
      "lng": "48.0979973",
      "lat": "29.1744729",
      "category": "Women's clothing store",
      "address": "Hadiya,",
      "address2": "",
      "city": "Kuwait",
      "state": "",
      "postal": "53GX+29",
      "country": "KW",
      "phone": "+965 94061091",
      "email": "",
      "web": "",
      "hours1": "",
      "hours2": "",
      "hours3": "",
      "featured": "",
      "features": ""
    },
    {
      "name": "Equila, The Sama Mall",
      "lng": "48.095111",
      "lat": "29.1695915",
      "category": "Women's clothing store",
      "address": "Layla Collection, Equila، Kuwait",
      "address2": "",
      "city": "Kuwait",
      "state": "",
      "postal": "539W+RW",
      "country": "KW",
      "phone": "+965 98715597",
      "email": "",
      "web": "",
      "hours1": "",
      "hours2": "",
      "hours3": "",
      "featured": "",
      "features": "539W+RW Hadiya, Kuwait"
    },
    {
      "name": "The Avenues Mall",
      "lng": "47.9313242",
      "lat": "29.3022091",
      "category": "Women's clothing store",
      "address": "Layla Collection, Sheikh Zayed Bin Sultan Al Nahyan Rd,",
      "address2": "",
      "city": "Kuwait",
      "state": "",
      "postal": "8W2J+VG",
      "country": "KW",
      "phone": "+965 22597544",
      "email": "",
      "web": "",
      "hours1": "",
      "hours2": "",
      "hours3": "",
      "featured": "",
      "features": ""
    },
    {
      "name": "Jahra",
      "lng": "47.6734616",
      "lat": "29.348072",
      "category": "Women's clothing store",
      "address": "Layla Collection, Ain Jalut St.,",
      "address2": "Awtad Mall, Jarah، Al Jahra,",
      "city": "Kuwait",
      "state": "",
      "postal": "8MXF+69",
      "country": "KW",
      "phone": "+965 98756933",
      "email": "",
      "web": "",
      "hours1": "",
      "hours2": "",
      "hours3": "",
      "featured": "",
      "features": ""
    },
    {
      "name": "Al Khiran",
      "lng": "48.0506875",
      "lat": "29.1995625",
      "category": "Women's clothing store",
      "address": "Layla Collection, Daher,",
      "address2": "",
      "city": "Kuwait",
      "state": "",
      "postal": "53X2+R7V",
      "country": "KW",
      "phone": "+965 98870299",
      "email": "",
      "web": "",
      "hours1": "",
      "hours2": "",
      "hours3": "",
      "featured": "",
      "features": ""
    }
  ]
};
