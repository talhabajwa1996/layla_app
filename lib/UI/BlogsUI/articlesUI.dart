import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Components/ArticleCard/articleCard.dart';
import 'package:layla_app_dev/UI/BlogsUI/articleDetailUI.dart';
import 'package:layla_app_dev/Utils/HelperFunctions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shopify_flutter/models/src/article/article.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../AppTheme/fontSizes.dart';
import '../../Widgets/Buttons/customBackButton.dart';
import '../ProductUI/FilteringUI/filteringUI.dart';

class ArticlesUI extends StatefulWidget {
  final Map<String, dynamic>? args;
  const ArticlesUI({super.key, this.args});

  @override
  State<ArticlesUI> createState() => _ArticlesUIState();
}

class _ArticlesUIState extends State<ArticlesUI> {

  List<Article> articlesList = [];
  int? index;
  AutoScrollController scrollController = AutoScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.args?["index"];
    articlesList = widget.args?["articlesList"];
    scrollController.scrollToIndex(index!, preferPosition: AutoScrollPosition.middle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 15.w, top: 8.sp, bottom: 8.sp),
          child: CustomBackButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        title:  Text("LAYLA'S BLOG", style: TextStyle(
            fontSize: FontSizes.largeText,
            fontWeight: FontWeight.w900,
            letterSpacing: 3
        ),),
      ),
      body: ListView.builder(
        controller: scrollController,
          itemCount: articlesList.length,
          itemBuilder: (context, index){
            return AutoScrollTag(
              key: ValueKey(index),
              controller: scrollController,
              index: index,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.sp),
                child: Column(
                  children: [
                    Text(HelperFunctions().convertDate(articlesList[index].publishedAt!), style: TextStyle(
                        fontSize: FontSizes.normalText1,
                        fontWeight: FontWeight.w900,
                    ),),
                    SizedBox(height: 5.sp,),
                    ArticleCard(
                      imageUrl: articlesList[index].image?.originalSrc,
                      title: articlesList[index].title,
                      onTap: (){
                        showBarModalBottomSheet(
                          context: context,
                          builder: (context) => ArticleDetailUI(
                            article: articlesList[index]
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
