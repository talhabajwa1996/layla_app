import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../AppTheme/ColorConstants.dart';

class CustomBackButton extends StatefulWidget {
  final Function()? onTap;
  const CustomBackButton({super.key, this.onTap});

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsetsDirectional.only(end: 3.w),
        child: Icon(
          CupertinoIcons.back,
          color: ColorConstants.textColorGrey,
          size: 22.sp,
        ),
      ),
    );
  }
}
