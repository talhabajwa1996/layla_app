import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/Widgets/Loaders/AppLoader.dart';
import 'package:shopify_flutter/models/src/blog/blog.dart';
import 'package:shopify_flutter/models/src/collection/collection.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../Components/CustomSectionsWithSaleOption/customSectionsWithSaleOption.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ShopifyService().shopifyStore.getAllCollections(),
      builder: (context, AsyncSnapshot<List<Collection>> snapshot) {
        if(!snapshot.hasData){
          return AppLoader();
        }else{
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: ListView(
              children: [
                SizedBox(height: 10.sp,),
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorConstants.secondaryColor,
                        borderRadius: BorderRadius.circular(5.r)
                    ),
                  ),
                ),
                CustomSectionsWithSaleOption(
                  title: "Best Sellers",
                  itemsList: ["1", "2", "3"],
                ),
                CustomSectionsWithSaleOption(
                  title: "Best Sellers",
                  itemsList: ["1", "2", "3"],
                ),

              ],
            ),
          );
        }
      }
    );
  }
}
