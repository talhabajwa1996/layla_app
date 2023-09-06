import 'package:flutter/material.dart';
import '../Utils/Constants/ColorConstants.dart';
import 'Images/AppLogo.dart';

PreferredSizeWidget logoAppBar(
        {bool? centerLogo,
        double logoSize = 50,
        Widget? leading,
        double? leadingWidth,
        List<Widget>? actions,
        PreferredSizeWidget? bottom}) =>
    AppBar(
      title: AppLogo(height: logoSize),
      centerTitle: centerLogo,
      backgroundColor: ColorConstants.white,
      foregroundColor: ColorConstants.black,
      leading: leading,
      leadingWidth: leadingWidth,
      bottom: bottom,
      actions: actions,
    );
