import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';

import '../../AppTheme/ColorConstants.dart';

class CustomExpandedListTile extends StatefulWidget {
  final String? title;
  final String? description;
  final bool selected;
  final Function(bool) onTap;

  const CustomExpandedListTile({Key? key, this.title, this.description, required this.onTap, required this.selected})
      : super(key: key);

  @override
  State<CustomExpandedListTile> createState() => _CustomExpandedListTileState();
}

class _CustomExpandedListTileState extends State<CustomExpandedListTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          widget.onTap.call(!widget.selected);
        });
      },
      // child: Padding(
      //   padding: EdgeInsets.only(bottom: 10.sp),
      //   child: AnimatedContainer(
      //     duration: const Duration(milliseconds: 300),
      //     width: 450.sp,
      //     height: widget.selected ? 140.sp : 50.sp,
      //     decoration: BoxDecoration(
      //       color: widget.selected ? ColorConstants.primaryColor.withOpacity(0.3) : ColorConstants.dullWhite,
      //       // gradient: widget.selected
      //       //     ? Gradient.lerp(gradientA, gradientB, 0.5)
      //       //     : GradientConstants.generalGradient(context),
      //       borderRadius: BorderRadius.circular(10.r),
      //     ),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Padding(
      //           padding: EdgeInsets.only(left: 15.0.w, right: 15.w, top: widget.selected ? 15.sp : 0),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Text(
      //                 widget.title!,
      //                 style: TextStyle(
      //                   fontSize: FontSizes.smallText,
      //                   fontWeight: FontWeight.w600,
      //                   height: 1.25,
      //                 ),
      //               ),
      //               Icon(
      //                 widget.selected
      //                     ? Icons.keyboard_arrow_up_rounded
      //                     : Icons.keyboard_arrow_down_rounded,
      //                 color: ColorConstants.textColorGrey,
      //                 size: 24.sp,
      //               )
      //             ],
      //           ),
      //         ),
      //         widget.selected ? Expanded(
      //           child: ListView(
      //             children: [
      //               SizedBox(
      //                 child: Padding(
      //                   padding: EdgeInsets.all(15.0.sp),
      //                   child: Text(
      //                     widget.description ?? '',
      //                     // textAlign: TextAlign.justify,
      //                     style: TextStyle(fontSize: FontSizes.smallText,
      //                         fontWeight: FontWeight.w400, height: 1.25, color: ColorConstants.textColorGrey.withOpacity(0.8)),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ): SizedBox(),
      //       ],
      //     ),
      //   ),
      // ),
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 300),
        firstChild: Padding(
          padding: EdgeInsets.only(bottom: 10.sp),
          child: Container(
            height: 50.sp,
            decoration: BoxDecoration(color: ColorConstants.dullWhite, borderRadius: BorderRadius.circular(10.r)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title!,
                    style: TextStyle(
                      fontSize: FontSizes.smallText,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: ColorConstants.textColorGrey,
                    size: 24.sp,
                  )
                ],
              ),
            ),
          ),
        ),
        secondChild: Padding(
          padding: EdgeInsets.only(bottom: 10.sp),
          child: Container(
            width: size.width,
            decoration: BoxDecoration(color: ColorConstants.dullWhite, borderRadius: BorderRadius.circular(10.r),
            gradient: LinearGradient(colors: [
              ColorConstants.primaryColor.withOpacity(0.3), ColorConstants.secondaryColor.withOpacity(0.1),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            border: Border.all(
              color: ColorConstants.textColorGrey.withOpacity(0.05)
            )),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title!,
                        style: TextStyle(
                          fontSize: FontSizes.smallText,
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_up_rounded,
                        color: ColorConstants.textColorGrey,
                        size: 24.sp,
                      )
                    ],
                  ),
                  SizedBox(height: 10.sp,),
                  SizedBox(
                    child: Text(
                      widget.description ?? '',
                      // textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: FontSizes.smallText,
                          fontWeight: FontWeight.w400,
                          height: 1.25,
                          color: ColorConstants.textColorGrey.withOpacity(0.8)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        crossFadeState: widget.selected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
    );
  }

// var gradientA = const LinearGradient(begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [ColorConstants.primaryBlue,ColorConstants.primaryOrange]);
//
// var gradientB = const LinearGradient(begin: Alignment.topRight,
//     end: Alignment.bottomRight,
//     colors: [ColorConstants.black,ColorConstants.primaryOrange]);
}
