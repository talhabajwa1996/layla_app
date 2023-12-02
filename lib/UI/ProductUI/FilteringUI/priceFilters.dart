import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/Controllers/FilteringController/filteringController.dart';
import 'package:layla_app_dev/Widgets/Buttons/CustomFilledButton.dart';
import 'package:layla_app_dev/Widgets/Buttons/OutlinedButton.dart';
import 'package:provider/provider.dart';

import '../../../AppTheme/fontSizes.dart';

class PriceFilters extends StatefulWidget {
  const PriceFilters({super.key});

  @override
  State<PriceFilters> createState() => _PriceFiltersState();
}

class _PriceFiltersState extends State<PriceFilters> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<FilteringController>(
        builder: (context, filteringProvider, child) {
          return Column(

            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.sp,),
                    Text(
                      "Highest Price is ${filteringProvider.maxPrice.toStringAsFixed(3)}",
                      style: TextStyle(fontSize: FontSizes.normalText2, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Lowest Price is ${filteringProvider.minPrice.toStringAsFixed(3)}",
                      style: TextStyle(fontSize: FontSizes.normalText2, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 30.sp,),
                    SliderTheme(
                      data: const SliderThemeData(showValueIndicator: ShowValueIndicator.always),
                      child: RangeSlider(
                        min: filteringProvider.minPrice,
                        max: filteringProvider.maxPrice,
                        values: filteringProvider.values,
                        onChanged: (value) {
                          filteringProvider.setRangeValues(value);
                        },
                        labels: RangeLabels(
                            filteringProvider.values.start.toStringAsFixed(3), filteringProvider.values.end.toStringAsFixed(3)),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Range from: ",
                          style: TextStyle(fontSize: FontSizes.normalText2, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "${filteringProvider.values.start.toStringAsFixed(3)} - ${filteringProvider.values.end.toStringAsFixed(3)}",
                          style: TextStyle(fontSize: FontSizes.normalText2, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25.sp, horizontal: 18.w),
                child: Container(
                  width: size.width,
                  height: 40.sp,
                  color: ColorConstants.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomOutlineButton(
                        title: "Clear",
                        height: 35.sp,
                        width: size.width * 0.4,
                        borderColor: ColorConstants.textColorGrey,
                        onPressed: (){
                          setState(() {
                            filteringProvider.initSliderValues();
                          });
                        },
                      ),
                      CustomFilledButton(
                        title: "Apply",
                        textColor: ColorConstants.textColorGrey,
                        height: 35.sp,
                        width: size.width * 0.4,
                        btnColor: ColorConstants.secondaryColor,
                        onPressed: (){
                          filteringProvider.setFiltersMap();
                          print("Map:: ${filteringProvider.filters}");
                          Navigator.pop(context, true);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }
    );
  }
}
