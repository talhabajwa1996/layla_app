import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/Controllers/FilteringController/filteringController.dart';
import 'package:layla_app_dev/Models/ProductModels/VariantOptionModel.dart';
import 'package:layla_app_dev/Widgets/Buttons/CustomFilledButton.dart';
import 'package:layla_app_dev/Widgets/Buttons/OutlinedButton.dart';
import 'package:provider/provider.dart';

class ColorFilters extends StatefulWidget {
  const ColorFilters({super.key});

  @override
  State<ColorFilters> createState() => _ColorFiltersState();
}

class _ColorFiltersState extends State<ColorFilters> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<FilteringController>(builder: (context, filteringProvider, child) {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: filteringProvider.availableColors.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(filteringProvider.availableColors[index]),
                      value: filteringProvider.checkTitleInProvider(filteringProvider.availableColors[index]),
                      onChanged: (value) {
                        filteringProvider.selectColors(filteringProvider.availableColors[index]);
                      });
                }),
          ),
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
                    onPressed: () {
                      setState(() {
                        filteringProvider.selectedColors.clear();
                      });
                    },
                  ),
                  CustomFilledButton(
                    title: "Apply",
                    textColor: ColorConstants.textColorGrey,
                    height: 35.sp,
                    width: size.width * 0.4,
                    btnColor: ColorConstants.secondaryColor,
                    onPressed: () {
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
    });
  }
}
