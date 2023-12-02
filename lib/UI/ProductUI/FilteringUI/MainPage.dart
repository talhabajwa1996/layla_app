import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Controllers/FilteringController/filteringController.dart';
import 'package:provider/provider.dart';

import '../../../AppTheme/ColorConstants.dart';
import '../../../AppTheme/fontSizes.dart';
import '../../../Widgets/Buttons/OutlinedButton.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 18.w),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    color: ColorConstants.textColorGrey.withOpacity(0.3)
                ))
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Size",
                style: TextStyle(fontSize: FontSizes.normalText2, fontWeight: FontWeight.w500),
              ),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: (){
                Provider.of<FilteringController>(context, listen: false).setPageIndex(1);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    color: ColorConstants.textColorGrey.withOpacity(0.3)
                ))
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Color",
                style: TextStyle(fontSize: FontSizes.normalText2, fontWeight: FontWeight.w500),
              ),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: (){
                Provider.of<FilteringController>(context, listen: false).setPageIndex(2);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    color: ColorConstants.textColorGrey.withOpacity(0.3)
                ))
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Price",
                style: TextStyle(fontSize: FontSizes.normalText2, fontWeight: FontWeight.w500),
              ),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: (){
                Provider.of<FilteringController>(context, listen: false).setPageIndex(3);
              },
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 13.sp),
            child: CustomOutlineButton(
              title: "Reset all filters",
              height: 35.sp,
              width: size.width,
              borderColor: ColorConstants.textColorGrey,
              onPressed: (){
                Provider.of<FilteringController>(context, listen: false).resetProvider();
              },
            ),
          ),
          // Text(
          //   "By Size",
          //   style: TextStyle(fontSize: FontSizes.normalText2, fontWeight: FontWeight.w600),
          // ),
          // SizedBox(
          //   height: 10.sp,
          // ),
          // SizedBox(
          //   height: 35.sp,
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: filteringProvider.availableSizes.length,
          //       itemBuilder: (context, index) {
          //         return InkWell(
          //           onTap: () {
          //             filteringProvider.selectSizes(filteringProvider.availableSizes[index]);
          //           },
          //           child: itemBox(filteringProvider.availableSizes[index], filteringProvider),
          //         );
          //       }),
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 30.sp, horizontal: 30.w),
          //   child: Divider(
          //     color: ColorConstants.textColorGrey.withOpacity(0.3),
          //   ),
          // ),
          // Text(
          //   "By Color",
          //   style: TextStyle(fontSize: FontSizes.normalText2, fontWeight: FontWeight.w600),
          // ),
          // SizedBox(
          //   height: 10.sp,
          // ),
          // SizedBox(
          //   height: 35.sp,
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: filteringProvider.availableColors.length,
          //       itemBuilder: (context, index) {
          //         return InkWell(
          //           onTap: () {
          //             filteringProvider.selectColors(filteringProvider.availableColors[index]);
          //           },
          //           child: itemBox(filteringProvider.availableColors[index], filteringProvider),
          //         );
          //       }),
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 30.sp, horizontal: 30.w),
          //   child: Divider(
          //     color: ColorConstants.textColorGrey.withOpacity(0.3),
          //   ),
          // ),
          // Text(
          //   "By Price Range",
          //   style: TextStyle(fontSize: FontSizes.normalText2, fontWeight: FontWeight.w600),
          // ),
          // SizedBox(
          //   height: 10.sp,
          // ),
          // SliderTheme(
          //   data: SliderThemeData(showValueIndicator: ShowValueIndicator.always),
          //   child: RangeSlider(
          //     min: filteringProvider.minPrice,
          //     max: filteringProvider.maxPrice,
          //     values: filteringProvider.values,
          //     onChanged: (value) {
          //       filteringProvider.setRangeValues(value);
          //     },
          //     labels: RangeLabels(
          //         filteringProvider.values.start.toStringAsFixed(1), filteringProvider.values.end.toStringAsFixed(1)),
          //   ),
          // ),
          // Text(
          //   "${filteringProvider.values.start.toStringAsFixed(1)} - ${filteringProvider.values.end.toStringAsFixed(1)}",
          //   style: TextStyle(fontSize: FontSizes.normalText2, fontWeight: FontWeight.w600),
          // ),
        ],
      ),
    );
  }
}
