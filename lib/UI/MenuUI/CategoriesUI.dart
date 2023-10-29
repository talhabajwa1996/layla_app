import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Models/MenuModels/MenuCollectionsResponseModel.dart';
import 'package:layla_app_dev/Services/ShopifyServices/Queries/menuItemsResources.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/Utils/Constants/RouteConstants.dart';

class CategoriesUI extends StatefulWidget {
  final MenuCollectionsResponseModel? collections;

  const CategoriesUI({super.key, this.collections});

  @override
  State<CategoriesUI> createState() => _CategoriesUIState();
}

class _CategoriesUIState extends State<CategoriesUI> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ListView.builder(
        itemCount: widget.collections?.menu?.items?.length,
        itemBuilder: (context, index) {
          var collectionItem = widget.collections?.menu?.items?[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 4.sp),
            child: InkWell(
              onTap: () {
                if (collectionItem!.subCollectionItems!.isNotEmpty) {
                  Navigator.pushNamed(context, RouteConstants.subCategories,
                      arguments: {'title': collectionItem.title, 'items': collectionItem.subCollectionItems});
                }else{
                  // Navigator.pushNamed(context, RouteConstants.products);
                  print(collectionItem.id!.replaceAll("MenuItem", "collections"));
                  fetchCollectionProductsById(collectionItem.id!);

                }
              },
              child: Container(
                width: size.width,
                height: 65.sp,
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                decoration: BoxDecoration(color: ColorConstants.dullWhite, borderRadius: BorderRadius.circular(5.r)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.5,
                        child: Text(
                          collectionItem?.title ?? "",
                          style: TextStyle(
                              fontSize: FontSizes.normalText1,
                              color: ColorConstants.textColorGrey.withOpacity(0.8),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      collectionItem?.subCollectionItems != null && collectionItem!.subCollectionItems!.isNotEmpty
                          ? Icon(
                              CupertinoIcons.forward,
                              size: 20.sp,
                              color: ColorConstants.textColorGrey.withOpacity(0.5),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  fetchCollectionProductsById(String menuItemId)async{
  //   const String menuItemResources = r'''
  //   query GetResourcesForMenuItem($menuItemId: ID!) {
  //     menuItem(id: $menuItemId) {
  //       linkedResource {
  //         __typename
  //         ... on Product {
  //           title
  //         }
  //         ... on Collection {
  //           title
  //         }
  //       }
  //     }
  //   }
  // ''';
  //   var future = await ShopifyService().shopifyStore.getCollectionByHandle('underwear');
  //   print(future);
  }
}
