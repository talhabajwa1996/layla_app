import 'package:flutter/material.dart';
import 'package:layla_app_dev/Components/Auth/LoginTab.dart';
import 'package:layla_app_dev/Components/Auth/SignupTab.dart';
import 'package:layla_app_dev/Controllers/AuthController/AuthController.dart';
import 'package:layla_app_dev/Utils/Constants/ColorConstants.dart';
import 'package:layla_app_dev/Utils/HelperFunctions.dart';
import 'package:layla_app_dev/Widgets/LogoAppBar.dart';
import 'package:provider/provider.dart';

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
      appBar: logoAppBar(),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height -
                Scaffold.of(context).appBarMaxHeight!,
            child: Stack(
              children: [
                Container(
                  height: 120,
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
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 60, bottom: 50),
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
                                          .login
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
                                          .signup
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
