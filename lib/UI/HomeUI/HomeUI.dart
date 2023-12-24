import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/Controllers/DashboardController/dashboardController.dart';
import 'package:layla_app_dev/UI/HomeUI/homeTab.dart';
import 'package:layla_app_dev/UI/SearchUI/searchTab.dart';
import 'package:layla_app_dev/Widgets/CustomAppBar/customSearchBar.dart';
import 'package:layla_app_dev/Widgets/CustomNavBar/customNavBar.dart';
import 'package:provider/provider.dart';
import '../CartUI/CartUI.dart';
import '../MenuUI/MenuTab.dart';

class HomeUI extends StatefulWidget {
  HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    MenuTab(),
    SearchTab(),
    CartUI()
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.white,
        foregroundColor: ColorConstants.white,
        surfaceTintColor: ColorConstants.white,
        leadingWidth: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   color: ColorConstants.dullWhite,
            //   height: 20.sp,
            //   width: size.width,
            // ),
            // SizedBox(height: 10.sp,),
            CustomSearchBar(),
          ],
        ),
        toolbarHeight: 75.sp,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<DashboardController>(
          builder: (context, dashboardProvider, child) {
        return tabs[dashboardProvider.selectedTabIndex];
      }),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
