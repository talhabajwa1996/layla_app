import 'package:flutter/material.dart';
import 'package:layla_app_dev/Utils/Constants/AppIcons.dart';
import '../../Utils/Constants/ColorConstants.dart';

PreferredSizeWidget searchAppBar(
        {bool? centerLogo,
        double logoSize = 50,
        Widget? leading,
        double? leadingWidth,
        List<Widget>? actions,
        PreferredSizeWidget? bottom}) =>
    AppBar(
      title: const Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(AppIcons.search,
                color: ColorConstants.searchText, size: 30),
          ),
          Text(
            'Search Products',
            style: TextStyle(fontSize: 18, color: ColorConstants.searchText),
          ),
        ],
      ),
      centerTitle: centerLogo,
      backgroundColor: ColorConstants.white,
      foregroundColor: ColorConstants.black,
      elevation: 0,
      leading: leading,
      leadingWidth: leadingWidth,
      bottom: bottom,
      actions: const [
        Icon(AppIcons.camera, color: ColorConstants.searchText, size: 27),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:
              Icon(AppIcons.scan, color: ColorConstants.searchText, size: 27),
        )
      ],
    );
