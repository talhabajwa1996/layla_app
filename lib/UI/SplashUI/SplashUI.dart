import 'dart:async';
import 'package:flutter/material.dart';
import 'package:layla_app_dev/Controllers/AuthController/AuthController.dart';
import 'package:layla_app_dev/Controllers/FavoriteController/FavoriteController.dart';
import 'package:layla_app_dev/Controllers/LocaleProvider.dart';
import 'package:layla_app_dev/Services/SharedPreferenceService/SharedPreferencesService.dart';
import 'package:layla_app_dev/Utils/Constants/KeysConstants.dart';
import 'package:layla_app_dev/Utils/HelperFunctions.dart';
import 'package:provider/provider.dart';
import '../../AppTheme/ColorConstants.dart';
import '../../Services/ShopifyServices/ShopifyServices.dart';
import '../../Utils/Constants/RouteConstants.dart';
import '../../Widgets/Images/AppLogo.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  _SplashScreenUIState createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI>
    with SingleTickerProviderStateMixin {
  Animation<double>? _iconAnimation;
  AnimationController? _iconAnimationController;

  void navigate() async {
    getDataFromLocalStorage();
    ShopifyService().getCurrentUserDetails();
    Provider.of<FavoriteController>(context, listen: false).initializeFavoriteController();
    Timer(const Duration(seconds: 4), () async {
      await HelperFunctions().checkFirstRun() ?
      Navigator.of(context).pushReplacementNamed(RouteConstants.selectLanguage)
          : Navigator.of(context).pushReplacementNamed(RouteConstants.home);
    });
  }

  @override
  void initState() {
    _iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
    _iconAnimation = CurvedAnimation(
      parent: _iconAnimationController!,
      curve: Curves.easeOutBack,
    );
    _iconAnimation!.addListener(() => setState(() {}));
    _iconAnimationController!.forward();
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: SizedBox(
            height: _iconAnimation!.value * size.height * 0.23,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(50.0),
                child: AppLogo(color: ColorConstants.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getDataFromLocalStorage() async {
    LocaleProvider localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    AuthController authController = Provider.of<AuthController>(context, listen: false);
    var code = await SharedPreferencesService().getString(KeysConstants.defaultLanguage);
    print("Country Code:: $code");
    if(code == "en"){
      localeProvider.setLocale(const Locale('en'));
    }else if(code == "ar"){
      localeProvider.setLocale(const Locale('ar'));
    }

    var currency = await SharedPreferencesService().getString(KeysConstants.defaultCurrency);
    print("Currency:: $currency");
    if(currency!.isNotEmpty){
      localeProvider.setCurrency(currency);
    }

    var userLoggedInStatus = await SharedPreferencesService().getString(KeysConstants.isUserLoggedIn);
    print("Is User Logged in:: $userLoggedInStatus");
    if(userLoggedInStatus == "true"){
      authController.setUserStatus = true;
    }else if(userLoggedInStatus == "false"){
      authController.setUserStatus = false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _iconAnimationController?.dispose();
    super.dispose();
  }
}
