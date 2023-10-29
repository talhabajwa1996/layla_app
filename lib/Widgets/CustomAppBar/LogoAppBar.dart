import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Widgets/Buttons/customBackButton.dart';
import '../../AppTheme/ColorConstants.dart';
import '../Images/AppLogo.dart';

PreferredSizeWidget logoAppBar(
        {bool? centerLogo,
        double logoSize = 50,
        Widget? leading,
        double? leadingWidth,
          bool showBackButton = false,
          Function()? onBackTap,
        List<Widget>? actions,
        PreferredSizeWidget? bottom}) =>
    AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          showBackButton ? CustomBackButton(onTap: onBackTap,): SizedBox(),
          AppLogo(height: logoSize),
          SizedBox(
            width: showBackButton ? 32.sp: 0.w,
          )
        ],
      ),
      centerTitle: centerLogo,
      backgroundColor: ColorConstants.white,
      foregroundColor: ColorConstants.black,
      leading: leading,
      leadingWidth: leadingWidth,
      bottom: bottom,
      actions: actions,
      automaticallyImplyLeading: false,
    );
