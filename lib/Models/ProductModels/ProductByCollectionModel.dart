class ProductByCollectionModel {
  ProductByCollectionData? data;

  ProductByCollectionModel({this.data});

  ProductByCollectionModel.fromJson(Map<String, dynamic> json) {
    print("we here in ProductByCollectionModel: $json");
    data = json['data'] != null ? new ProductByCollectionData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProductByCollectionData {
  CollectionByHandle? collectionByHandle;

  ProductByCollectionData({this.collectionByHandle});

  ProductByCollectionData.fromJson(Map<String, dynamic> json) {
    collectionByHandle = json['collectionByHandle'] != null
        ? new CollectionByHandle.fromJson(json['collectionByHandle'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collectionByHandle != null) {
      data['collectionByHandle'] = this.collectionByHandle!.toJson();
    }
    return data;
  }
}

class CollectionByHandle {
  Products? products;

  CollectionByHandle({this.products});

  CollectionByHandle.fromJson(Map<String, dynamic> json) {
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    return data;
  }
}

class Products {
  List<ProductEdges>? edges;

  Products({this.edges});

  Products.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edges = <ProductEdges>[];
      json['edges'].forEach((v) {
        edges!.add(new ProductEdges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.edges != null) {
      data['edges'] = this.edges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductEdges {
  ProductNode? node;

  ProductEdges({this.node});

  ProductEdges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? new ProductNode.fromJson(json['node']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.node != null) {
      data['node'] = this.node!.toJson();
    }
    return data;
  }
}

class ProductNode {
  String? createdAt;
  String? id;
  String? title;
  String? description;
  bool? availableForSale;
  PriceRange? compareAtPriceRange;
  ProductImages? images;
  PriceRange? priceRange;
  List<Options>? options;

  ProductNode(
      {this.createdAt,
        this.id,
        this.title,
        this.description,
        this.availableForSale,
        this.compareAtPriceRange,
        this.images,
        this.priceRange,
        this.options});

  ProductNode.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    availableForSale = json['availableForSale'];
    compareAtPriceRange = json['compareAtPriceRange'] != null
        ? new PriceRange.fromJson(json['compareAtPriceRange'])
        : null;
    images =
    json['images'] != null ? new ProductImages.fromJson(json['images']) : null;
    priceRange = json['priceRange'] != null
        ? new PriceRange.fromJson(json['priceRange'])
        : null;
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['availableForSale'] = this.availableForSale;
    if (this.compareAtPriceRange != null) {
      data['compareAtPriceRange'] = this.compareAtPriceRange!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    if (this.priceRange != null) {
      data['priceRange'] = this.priceRange!.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageNode {
  String? originalSrc;
  dynamic altText;

  ImageNode({this.originalSrc, this.altText});

  ImageNode.fromJson(Map<String, dynamic> json) {
    originalSrc = json['originalSrc'];
    altText = json['altText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['originalSrc'] = this.originalSrc;
    data['altText'] = this.altText;
    return data;
  }
}

class PriceRange {
  MinVariantPrice? minVariantPrice;

  PriceRange({this.minVariantPrice});

  PriceRange.fromJson(Map<String, dynamic> json) {
    minVariantPrice = json['minVariantPrice'] != null
        ? new MinVariantPrice.fromJson(json['minVariantPrice'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.minVariantPrice != null) {
      data['minVariantPrice'] = this.minVariantPrice!.toJson();
    }
    return data;
  }
}

class MinVariantPrice {
  String? amount;
  String? currencyCode;

  MinVariantPrice({this.amount, this.currencyCode});

  MinVariantPrice.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currencyCode = json['currencyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currencyCode'] = this.currencyCode;
    return data;
  }
}

class ProductImages {
  List<ImageEdges>? edges;

  ProductImages({this.edges});

  ProductImages.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edges = <ImageEdges>[];
      json['edges'].forEach((v) {
        edges!.add(new ImageEdges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.edges != null) {
      data['edges'] = this.edges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageEdges {
  ImageNode? node;

  ImageEdges({this.node});

  ImageEdges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? new ImageNode.fromJson(json['node']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.node != null) {
      data['node'] = this.node!.toJson();
    }
    return data;
  }
}

class Options {
  String? name;
  List<String>? values;

  Options({this.name, this.values});

  Options.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    values = json['values'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['values'] = this.values;
    return data;
  }
}

