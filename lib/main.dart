import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:layla_app_dev/Controllers/AuthController/AuthController.dart';
import 'package:layla_app_dev/Controllers/LocaleProvider.dart';
import 'package:layla_app_dev/Routes/Routes.dart';
import 'package:layla_app_dev/Services/API/api.dart';
import 'package:layla_app_dev/Utils/Constants/ColorConstants.dart';
import 'package:layla_app_dev/Utils/Constants/RouteConstants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
 GraphqlApi.config();
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
      ],
      child: ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        child: Consumer<LocaleProvider>(
          builder: (context,localeProvider,child) {
            return MaterialApp(
              title: 'E-commerce Application (Android, iOS) integrated with Shopify.',
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: localeProvider.selectedLocale,
              supportedLocales: const [
                Locale('en'), Locale('ar')
              ],
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.primaryColor),
                useMaterial3: true,
              ),
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: RouteConstants.initialRoute,
            );
          }
        ),
      ),
    );
  }
}
