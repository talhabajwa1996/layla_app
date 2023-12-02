import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Widgets/Images/NetworkImage.dart';
import 'package:shopify_flutter/models/models.dart';

import '../../Utils/HelperFunctions.dart';

class ArticleDetailUI extends StatefulWidget {
  final Article? article;
  const ArticleDetailUI({super.key, this.article});

  @override
  State<ArticleDetailUI> createState() => _ArticleDetailUIState();
}

class _ArticleDetailUIState extends State<ArticleDetailUI> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ListView(
      children: [
        SizedBox(
          width: size.width,
          height: 275.sp,
          child: appNetworkImage(widget.article?.image?.originalSrc, double.infinity, double.infinity,
              BoxFit.cover),
        ),
        SizedBox(height: 10.sp,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Wrap(
            children: [
              Text(widget.article!.title!, style: TextStyle(
                  fontSize: FontSizes.largeText,
                  fontWeight: FontWeight.w600,
                  height: 1.5
              ),),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.sp),
                child: Divider(
                  color: ColorConstants.textColorGrey.withOpacity(0.25),
                ),
              ),
              Text(HelperFunctions().convertDate(widget.article?.publishedAt!), style: TextStyle(
                fontSize: FontSizes.normalText1,
                fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 5.sp,),
              Html(
                data: widget.article?.contentHtml!,
              )
            ],
          ),
        )

      ],
    );
  }
}
