import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/Controllers/FilteringController/filteringController.dart';
import 'package:layla_app_dev/Widgets/Buttons/CustomFilledButton.dart';
import 'package:layla_app_dev/Widgets/Buttons/OutlinedButton.dart';
import 'package:provider/provider.dart';

class SizeFilters extends StatefulWidget {
  const SizeFilters({super.key});

  @override
  State<SizeFilters> createState() => _SizeFiltersState();
}

class _SizeFiltersState extends State<SizeFilters> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<FilteringController>(
      builder: (context, filteringProvider, child) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: filteringProvider.availableSizes.length,
                  itemBuilder: (context, index){
                    return CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(filteringProvider.availableSizes[index]),
                        value: filteringProvider.checkTitleInProvider(filteringProvider.availableSizes[index]),
                        onChanged: (value){
                          filteringProvider.selectSizes(filteringProvider.availableSizes[index]);
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
                      onPressed: (){
                        setState(() {
                          filteringProvider.selectedSizes.clear();
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
