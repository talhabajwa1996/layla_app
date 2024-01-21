import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/appTheme.dart';
import 'package:layla_app_dev/Controllers/AddressController/AddressController.dart';
import 'package:layla_app_dev/Controllers/AuthController/AuthController.dart';
import 'package:layla_app_dev/Controllers/CartControllers/CartController.dart';
import 'package:layla_app_dev/Controllers/CheckoutController/CheckoutController.dart';
import 'package:layla_app_dev/Controllers/DashboardController/dashboardController.dart';
import 'package:layla_app_dev/Controllers/ExchangeAndReturnController/exchangeAndReturnController.dart';
import 'package:layla_app_dev/Controllers/FavoriteController/FavoriteController.dart';
import 'package:layla_app_dev/Controllers/FilteringController/filteringController.dart';
import 'package:layla_app_dev/Controllers/LocaleProvider.dart';
import 'package:layla_app_dev/Controllers/SortingController/sortingController.dart';
import 'package:layla_app_dev/Routes/Routes.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Controllers/LocationController/locationController.dart';
import 'Controllers/SearchBarController/searchBarController.dart';
import 'Services/API/api.dart';
import 'Utils/Constants/RouteConstants.dart';

void main() {
  GraphqlApi.config();
  ShopifyService().initShopify();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(
          create: (context) => AuthController(),
        ),
        ChangeNotifierProvider<SearchBarController>(
          create: (context) => SearchBarController(),
        ),
        ChangeNotifierProvider<DashboardController>(
          create: (context) => DashboardController(),
        ),
        ChangeNotifierProvider<FavoriteController>(
          create: (context) => FavoriteController(),
        ),
        ChangeNotifierProvider<FilteringController>(
          create: (context) => FilteringController(),
        ),
        ChangeNotifierProvider<SortingController>(
          create: (context) => SortingController(),
        ),
        ChangeNotifierProvider<ExchangeAndReturnController>(
          create: (context) => ExchangeAndReturnController(),
        ),
        ChangeNotifierProvider<LocationController>(
          create: (context) => LocationController(),
        ),
        ChangeNotifierProvider<CartController>(
          create: (context) => CartController(),
        ),
        ChangeNotifierProvider<CheckoutController>(
          create: (context) => CheckoutController(),
        ),
        ChangeNotifierProvider<AddressController>(
          create: (context) => AddressController(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        child:
            Consumer<LocaleProvider>(builder: (context, localeProvider, child) {
          return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp(
                  title:
                      'E-commerce Application (Android, iOS) integrated with Shopify.',
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  locale: localeProvider.selectedLocale,
                  supportedLocales: const [Locale('en'), Locale('ar')],
                  theme: AppTheme().buildTheme(Brightness.dark),
                  onGenerateRoute: RouteGenerator.generateRoute,
                  initialRoute: RouteConstants.initialRoute,
                );
              });
        }),
      ),
    );
  }
}
