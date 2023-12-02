import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/Components/CustomSectionsWithSaleOption/customSectionsWithSaleOption.dart';
import 'package:layla_app_dev/Controllers/DashboardController/dashboardController.dart';
import 'package:layla_app_dev/UI/CartUI/cartTab.dart';
import 'package:layla_app_dev/UI/HomeUI/homeTab.dart';
import 'package:layla_app_dev/UI/SearchUI/searchTab.dart';
import 'package:layla_app_dev/Widgets/CustomAppBar/customSearchBar.dart';
import 'package:layla_app_dev/Widgets/CustomNavBar/customNavBar.dart';
import 'package:layla_app_dev/Widgets/Images/AppLogo.dart';
import 'package:provider/provider.dart';

import '../MenuUI/MenuTab.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  final List<Widget> tabs = const[HomeTab(), SearchTab(), MenuTab(), SearchTab(), CartTab()];

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {



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
          return widget.tabs[dashboardProvider.selectedTabIndex];
        }
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
