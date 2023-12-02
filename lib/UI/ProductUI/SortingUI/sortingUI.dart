import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Controllers/SortingController/sortingController.dart';
import 'package:provider/provider.dart';

import '../../../AppTheme/ColorConstants.dart';
import '../../../AppTheme/fontSizes.dart';

class SortingUI extends StatefulWidget {
  const SortingUI({super.key});

  @override
  State<SortingUI> createState() => _SortingUIState();
}

class _SortingUIState extends State<SortingUI> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<SortingController>(builder: (context, sortingProvider, child) {
      return SizedBox(
        height: size.height * 0.65,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 15.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.arrow_up_arrow_down,
                          size: 15.sp,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          "Sort",
                          style: TextStyle(fontSize: FontSizes.largeText, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Icon(CupertinoIcons.clear))
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: sortingProvider.sorting.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: ColorConstants.textColorGrey.withOpacity(0.1)))),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            minLeadingWidth: 0,
                            enableFeedback: true,
                            splashColor: ColorConstants.transparent,
                            onTap: () {
                              sortingProvider.setSelectedIndex(index);
                            },
                            leading: CupertinoRadio<int>(
                              activeColor: ColorConstants.secondary1Color,
                              toggleable: true,
                              value: index,
                              groupValue: sortingProvider.selectedIndex,
                              onChanged: (value) {},
                            ),
                            title: Text(sortingProvider.sorting[index]),
                          ),
                        ),
                      );
                    }))
          ],
        ),
      );
    });
  }
}
