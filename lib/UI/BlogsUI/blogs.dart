import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Widgets/Images/NetworkImage.dart';
import 'package:shopify_flutter/models/src/article/article.dart';
import 'package:shopify_flutter/models/src/blog/blog.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../AppTheme/fontSizes.dart';
import '../../Services/ShopifyServices/ShopifyServices.dart';
import '../../Utils/Constants/RouteConstants.dart';
import '../../Widgets/Loaders/AppLoader.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return FutureBuilder(
        future: ShopifyService().shopifyBlog.getAllBlogs(),
        builder: (context, AsyncSnapshot<List<Blog>?> snapshot) {
          if(!snapshot.hasData){
            return AppLoader();
          }else{
            List<Article>? articleslist = snapshot.data?.first.articles?.articleList.toList();
            articleslist?.sort((a, b){
              return b.publishedAt!.compareTo(a.publishedAt!);
            });
            return Container(
              color: ColorConstants.textColorGrey.withOpacity(0.1),
              width: size.width,
              height: 350.sp,
              child: Column(
                children: [
                  SizedBox(height: 10.sp,),
                  Text("LAYLA'S BLOG", style: TextStyle(
                      fontSize: FontSizes.largeText,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3
                  ),),
                  SizedBox(height: 3.sp,),
                  Text("A WORLD OF INSPIRATION", style: TextStyle(
                      fontSize: FontSizes.normalText1,
                      fontWeight: FontWeight.w400
                  ),),
                  SizedBox(height: 15.sp,),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: articleslist!.length,
                        itemBuilder: (context, index){
                        var blogsData = articleslist[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, RouteConstants.articles, arguments: {
                                  "index": index,
                                  "articlesList": articleslist
                                });
                              },
                              child: UnconstrainedBox(
                                child: Container(
                                  width: size.width*0.9,
                                  height: 250.sp,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.white,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),

                                  child: Column(
                                    children: [
                                     Expanded(
                                       child: appNetworkImage(blogsData.image?.originalSrc,
                                           double.infinity, double.infinity,
                                           BoxFit.cover),
                                     ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 60.sp,
                                          child: Text(blogsData.title ?? "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: FontSizes.smallText,
                                              fontWeight: FontWeight.w600,
                                          ),),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          }
        }
    );
  }
}
