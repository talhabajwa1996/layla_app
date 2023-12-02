import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/Controllers/FavoriteController/FavoriteController.dart';
import 'package:layla_app_dev/Widgets/Notifiers/Toast.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  final String? productId;
  final Color? boxColor;

  const FavoriteButton({super.key, this.boxColor, this.productId});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteController>(builder: (context, favoriteProvider, child) {
      return InkWell(
        onTap: () {
          favoriteProvider.setItemFavorite(widget.productId!);

        },
        child: Container(
          width: 28.sp,
          height: 28.sp,
          decoration: BoxDecoration(
              color: widget.boxColor ?? ColorConstants.white.withOpacity(0.4), borderRadius: BorderRadius.circular(5.r)),
          child: Center(
              child: Icon(
            favoriteProvider.favoriteItems.contains(widget.productId) ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
            size: 18.sp,
            color: favoriteProvider.favoriteItems.contains(widget.productId)
                ? ColorConstants.primaryColor
                : ColorConstants.textColorGrey.withOpacity(0.8),
          )),
        ),
      );
    });
  }
}
