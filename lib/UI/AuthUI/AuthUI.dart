import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Components/Auth/LoginTab.dart';
import 'package:layla_app_dev/Components/Auth/SignupTab.dart';
import 'package:layla_app_dev/Controllers/AuthController/AuthController.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/Utils/HelperFunctions.dart';
import 'package:layla_app_dev/Widgets/CustomAppBar/LogoAppBar.dart';
import 'package:provider/provider.dart';

import '../../Controllers/DashboardController/dashboardController.dart';

class AuthUI extends StatefulWidget {
  const AuthUI({super.key});

  @override
  State<AuthUI> createState() => _AuthUIState();
}

class _AuthUIState extends State<AuthUI> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    Provider.of<AuthController>(context, listen: false).initialize(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: logoAppBar(
        showBackButton: true,
        onBackTap: (){
          Provider.of<DashboardController>(context, listen: false).setTabIndex = 0;
          Navigator.of(context).pop();
        }
      ),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height -
                Scaffold.of(context).appBarMaxHeight!,
            child: Stack(
              children: [
                Container(
                  height: 120.sp,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorConstants.primaryColor.withOpacity(0.3),
                        ColorConstants.primaryColor.withOpacity(0.8)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Consumer<AuthController>(
                    builder: (context, authController, child) {
                  return Card(
                    color: ColorConstants.white,
                    surfaceTintColor: Colors.transparent,
                    margin: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 60.sp, bottom: 50.sp),
                    child: Theme(
                      data: ThemeData(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                      ),
                      child: Column(
                        children: [
                          TabBar(
                            controller: authController.authTabController,
                            dividerColor: Colors.transparent,
                            indicator: const BoxDecoration(),
                            onTap: (index) => authController.setTabIndex(index),
                            tabs: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: authController.currentTabIndex == 0
                                        ? ColorConstants.white
                                        : ColorConstants.dullWhite,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                      localizedText(context)
                                          !.login
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          color: ColorConstants.textColorGrey,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: authController.currentTabIndex == 1
                                        ? ColorConstants.white
                                        : ColorConstants.dullWhite,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                      localizedText(context)
                                          !.signup
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          color: ColorConstants.textColorGrey,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                                controller: authController.authTabController,
                                children: const [LoginTab(), SignupTab()]),
                          )
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          );
        }),
      ),
    );
  }
}
