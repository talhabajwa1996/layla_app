import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Controllers/DashboardController/dashboardController.dart';
import 'package:layla_app_dev/Controllers/SearchBarController/searchBarController.dart';
import 'package:layla_app_dev/Utils/Constants/ImageConstants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../Controllers/AuthController/AuthController.dart';
import '../../Utils/Constants/RouteConstants.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthController, DashboardController, SearchBarController>(builder: (context,authController, dashboardProvider,searchBarProvider, child) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorConstants.textColorGrey.withOpacity(0.2),
              offset: Offset(0, 5.sp),
              spreadRadius: 3,
              blurRadius: 10
            )
          ]
        ),
        child: CupertinoTabBar(
          currentIndex: dashboardProvider.selectedTabIndex,
          backgroundColor: ColorConstants.white,
          height: 70.sp,
          border: const Border(),
          items: [
            BottomNavigationBarItem(
                icon: SizedBox(
                    width: 35.sp,
                    height: 35.sp,
                    child: Image.asset(ImageConstants.homeIcon))),
            BottomNavigationBarItem(icon: SizedBox(
                width: 35.sp,
                height: 35.sp,
                child: Image.asset(ImageConstants.searchIcon))),
            BottomNavigationBarItem(
                icon: Text("MENU", style: GoogleFonts.sofiaSansCondensed(
                  textStyle: TextStyle(
                      fontSize: FontSizes.normalText1,
                      fontWeight: FontWeight.w900,
                      color: ColorConstants.textColorGrey,
                      height: 1.25
                  )
                ),)),
            BottomNavigationBarItem(
                icon: SizedBox(
                    width: 35.sp,
                    height: 35.sp,
                    child: Image.asset(ImageConstants.userIcon))),
            BottomNavigationBarItem(
                icon: SizedBox(
                    width: 35.sp,
                    height: 35.sp,
                    child: Image.asset(ImageConstants.cartIcon))),
          ],
          onTap: (index) {
            dashboardProvider.setTabIndex = index;
            if(index != 1){
              searchBarProvider.setSearching = false;
              if(index == 3){
                authController.isUserLoggedIn
                    ? Navigator.pushNamed(context, RouteConstants.settings)
                    : Navigator.pushNamed(context, RouteConstants.auth);
              }
            }
          },
        ),
      );
    });
  }

  Widget navBarIcon(String asset, Color? svgColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.sp),
      child: WebsafeSvg.asset(
        asset,
        width: 18.sp,
        height: 18.sp,
        alignment: Alignment.center,
        colorFilter: ColorFilter.mode(
          svgColor!,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
