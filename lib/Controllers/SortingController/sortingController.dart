import 'package:flutter/cupertino.dart';

import '../../Models/ProductModels/ProductByCollectionModel.dart';

class SortingController extends ChangeNotifier {
  int selectedIndex = 0;
  List<String> sorting = [
    "Featured",
    "Best Selling",
    "Alphabetically, A-Z",
    "Alphabetically, Z-A",
    "Price, low to high",
    "Price, high to low",
    "Date, old to new",
    "Date, new to old",
  ];

  setSelectedIndex(value) {
    selectedIndex = value;
    notifyListeners();
  }

  setSorting(List<ProductEdges>? products) {
    if (selectedIndex == 0) {
      /// Featured
      return products;
    } else if (selectedIndex == 1) {
      /// Best Selling

    } else if (selectedIndex == 2) {
      /// Alphabetically, A-Z
      products?.sort((a, b) {
        var productA = a.node?.title;
        var productB = b.node?.title;

        return productA!.compareTo(productB!);
      });
    } else if (selectedIndex == 3) {
      /// Alphabetically, Z-A
      products?.sort((a, b) {
        var productA = a.node?.title;
        var productB = b.node?.title;

        return productB!.compareTo(productA!);
      });
    } else if (selectedIndex == 4) {
      /// Price, low to high
      products?.sort((a, b) {
        var priceA = double.parse(a.node!.priceRange!.minVariantPrice!.amount!);
        var priceB = double.parse(b.node!.priceRange!.minVariantPrice!.amount!);

        return priceA.compareTo(priceB);
      });
    } else if (selectedIndex == 5) {
      /// Price, high to low
      products?.sort((a, b) {
        var priceA = double.parse(a.node!.priceRange!.minVariantPrice!.amount!);
        var priceB = double.parse(b.node!.priceRange!.minVariantPrice!.amount!);

        return priceB.compareTo(priceA);
      });
    }else if (selectedIndex == 6) {
      /// Date, old to new
      products?.sort((a, b) {
        var dateA = DateTime.parse(a.node!.createdAt!);
        var dateB = DateTime.parse(b.node!.createdAt!);

        return dateA.compareTo(dateB);
      });
    }else if (selectedIndex == 7) {
      /// Date, new to old
      products?.sort((a, b) {
        var dateA = DateTime.parse(a.node!.createdAt!);
        var dateB = DateTime.parse(b.node!.createdAt!);

        return dateB.compareTo(dateA);
      });
    }
    notifyListeners();
  }
}
