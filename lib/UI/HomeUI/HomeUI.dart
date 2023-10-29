import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/Components/CustomSectionsWithSaleOption/customSectionsWithSaleOption.dart';
import 'package:layla_app_dev/Controllers/DashboardController/dashboardController.dart';
import 'package:layla_app_dev/UI/HomeUI/homeTab.dart';
import 'package:layla_app_dev/UI/SearchUI/searchTab.dart';
import 'package:layla_app_dev/Widgets/CustomAppBar/customSearchBar.dart';
import 'package:layla_app_dev/Widgets/CustomNavBar/customNavBar.dart';
import 'package:layla_app_dev/Widgets/Images/AppLogo.dart';
import 'package:provider/provider.dart';

import '../MenuUI/MenuTab.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {

  final List _tabs = const[HomeTab(), SearchTab(), MenuTab(), SearchTab(), HomeTab()];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppLogo(
              height: 50.sp,
            ),
            CustomSearchBar(),
          ],
        ),
        toolbarHeight: 100.sp,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<DashboardController>(
        builder: (context, dashboardProvider, child) {
          return _tabs[dashboardProvider.selectedTabIndex];
        }
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
