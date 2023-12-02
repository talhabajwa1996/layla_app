import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Controllers/FilteringController/filteringController.dart';
import 'package:layla_app_dev/UI/ProductUI/FilteringUI/MainPage.dart';
import 'package:layla_app_dev/UI/ProductUI/FilteringUI/colorFilters.dart';
import 'package:layla_app_dev/UI/ProductUI/FilteringUI/priceFilters.dart';
import 'package:layla_app_dev/UI/ProductUI/FilteringUI/sizeFilters.dart';
import 'package:provider/provider.dart';

class FilteringUI extends StatefulWidget {
  const FilteringUI({super.key});

  @override
  State<FilteringUI> createState() => _FilteringUIState();
}

class _FilteringUIState extends State<FilteringUI> {
  final _pages = [MainPage(), SizeFilters(), ColorFilters(), PriceFilters()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<FilteringController>(builder: (context, filteringProvider, child) {
      return SizedBox(
        // height: size.height * 0.75,
        child: Column(
          children: [
            SizedBox(height: 15.sp,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  filteringProvider.pageIndex != 0
                      ? InkWell(onTap: () {
                        filteringProvider.setPageIndex(0);
                  }, child: Icon(CupertinoIcons.arrow_left))
                      : SizedBox(
                          width: 20.w,
                        ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.slider_horizontal_3),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Filters",
                          style: TextStyle(fontSize: FontSizes.largeText, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  InkWell(onTap: () {
                    filteringProvider.setPageIndex(0);
                    Navigator.of(context).pop();
                  }, child: Icon(CupertinoIcons.clear))
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                  controller: filteringProvider.controller,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _pages[filteringProvider.pageIndex];
                  }),
            ),
          ],
        ),
      );
    });
  }

// Widget itemBox(String title, FilteringController filteringProvider) {
//   return UnconstrainedBox(
//     child: Padding(
//       padding: EdgeInsets.only(right: 5.w),
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(3.r),
//             color: checkTitleInProvider(title) ? ColorConstants.primaryColor : ColorConstants.white,
//             border: Border.all(color: ColorConstants.textColorGrey.withOpacity(0.6)),
//             boxShadow: [BoxShadow(color: ColorConstants.textColorGrey.withOpacity(0.1), spreadRadius: 2, blurRadius: 1)]),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.sp),
//           child: Center(
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontSize: FontSizes.smallText,
//                 fontWeight: checkTitleInProvider(title) ? FontWeight.w600 : FontWeight.w400,
//                 color: checkTitleInProvider(title) ? ColorConstants.white : ColorConstants.textColorGrey,
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
}
