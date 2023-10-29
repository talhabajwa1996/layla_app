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
      child: Container(
        width: 32.sp,
        height: 32.sp,
        decoration: BoxDecoration(
            color: ColorConstants.secondaryColor.withOpacity(0.5), borderRadius: BorderRadius.circular(10.r)),
        child: Center(
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 3.w),
              child: Icon(
                CupertinoIcons.back,
                color: ColorConstants.textColorGrey.withOpacity(0.8),
              ),
            )),
      ),
    );
  }
}
