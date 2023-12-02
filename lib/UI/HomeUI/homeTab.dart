import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/UI/BlogsUI/blogs.dart';
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
    Size size = MediaQuery.sizeOf(context);
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConstants.secondaryColor,
                  borderRadius: BorderRadius.circular(5.r)
              ),
            ),
          ),
        ),
        const CustomSectionsWithSaleOption(
          title: "Best Sellers",
        ),
        const CustomSectionsWithSaleOption(
          title: "Best Sellers",
        ),
        Blogs(),

      ],
    );;
  }
}
