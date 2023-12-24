import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Controllers/FilteringController/filteringController.dart';
import 'package:layla_app_dev/Controllers/SortingController/sortingController.dart';
import 'package:layla_app_dev/Models/ProductModels/ProductByCollectionModel.dart';
import 'package:layla_app_dev/Services/ShopifyServices/Queries/getProductsByCollectionWithFilters.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/UI/ProductUI/ProductsView.dart';
import 'package:provider/provider.dart';
import '../../AppTheme/ColorConstants.dart';
import '../../AppTheme/fontSizes.dart';
import '../../Widgets/Buttons/customBackButton.dart';
import '../../Widgets/Loaders/AppLoader.dart';

class ProductUI extends StatefulWidget {
  final Map<String, dynamic>? args;

  const ProductUI({super.key, this.args});

  @override
  State<ProductUI> createState() => _ProductUIState();
}

class _ProductUIState extends State<ProductUI> {
  String? handle;
  String? title;
  Future<Map<String, dynamic>?>? getProducts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Uri uri = Uri.parse(widget.args?['handle']);
    handle = uri.pathSegments.last;
    print("Handle:: $handle");
    getProducts = ShopifyService().shopifyCustom.customQuery(
        gqlQuery: getProductsByCollectionWithFilters,
        variables: {'collectionHandle': handle, 'filters': Provider.of<FilteringController>(context, listen: false).filters});
    title = widget.args?['title'];
  }

  Future<void> _handleRefresh() async {
    getProducts = ShopifyService().shopifyCustom.customQuery(
        gqlQuery: getProductsByCollectionWithFilters,
        variables: {'collectionHandle': handle, 'filters': Provider.of<FilteringController>(context, listen: false).filters});
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.only(left: 15.w, top: 8.sp, bottom: 8.sp),
            child: CustomBackButton(
              onTap: () {
                Provider.of<FilteringController>(context, listen: false).resetProvider();
                Provider.of<SortingController>(context, listen: false).setSelectedIndex(0);
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(
            title ?? "",
            style: TextStyle(fontSize: FontSizes.normalText1, color: ColorConstants.primaryColor, fontWeight: FontWeight.w600),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: FutureBuilder(
              future: getProducts,
              builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                if (!snapshot.hasData) {
                  return const AppLoader();
                } else {
                  ProductByCollectionData responseModel = ProductByCollectionData.fromJson(snapshot.data!);
                  return ProductsView(
                    products: responseModel.collectionByHandle?.products,
                    handleRefresh: _handleRefresh,
                  );
                }
              }),
        ));
  }
}
