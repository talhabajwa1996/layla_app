import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../AppTheme/fontSizes.dart';
import '../../Widgets/Images/NetworkImage.dart';

class ArticleCard extends StatefulWidget {
  final String? imageUrl;
  final String? title;
  final Function()? onTap;
  const ArticleCard({super.key, this.imageUrl, this.title, this.onTap});

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size.width * 0.9,
          height: 275.sp,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: ColorConstants.secondaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5.r),
          ),

          child: Column(
            children: [
              Expanded(
                child: appNetworkImage(widget.imageUrl,
                    double.infinity, double.infinity,
                    BoxFit.cover),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: SizedBox(
                  height: 75.sp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(widget.title ?? "",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: FontSizes.smallText,
                          fontWeight: FontWeight.w600,
                        ),),
                      Text("Read the story →",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: FontSizes.extraSmallText,
                          fontWeight: FontWeight.w400,
                        ),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
