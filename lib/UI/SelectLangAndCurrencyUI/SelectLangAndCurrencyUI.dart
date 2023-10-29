import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Controllers/LocaleProvider.dart';
import 'package:layla_app_dev/Services/SharedPreferenceService/SharedPreferencesService.dart';
import 'package:layla_app_dev/Utils/Constants/KeysConstants.dart';
import 'package:layla_app_dev/Utils/Constants/RouteConstants.dart';
import 'package:layla_app_dev/Utils/HelperFunctions.dart';
import 'package:layla_app_dev/Widgets/Buttons/CustomFilledButton.dart';
import 'package:layla_app_dev/Widgets/Images/AppLogo.dart';
import 'package:provider/provider.dart';
import '../../AppTheme/ColorConstants.dart';
import '../../Widgets/Buttons/CustomElevatedButton.dart';

class SelectLangAndCurrencyUI extends StatefulWidget {
  const SelectLangAndCurrencyUI({super.key});

  static const List<String> availableCurrencies = ["KWD", "SAR", "AED", "QAR", "OMR", "BHD", "USD", "EUR"];

  @override
  State<SelectLangAndCurrencyUI> createState() => _SelectLangAndCurrencyUIState();
}

class _SelectLangAndCurrencyUIState extends State<SelectLangAndCurrencyUI> {
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Consumer<LocaleProvider>(builder: (context, localeProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppLogo(
                  width: size.width * 0.5,
                ),
                Column(
                  children: [
                    Text(
                      localizedText(context)!.select_your_preferred_language,
                      style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomFilledButton(
                            title: 'english',
                            width: size.width * 0.4,
                            height: 30.sp,
                            fontSize: FontSizes.smallText,
                            btnRadius: 5.r,
                            btnColor: localeProvider.selectedLocale.languageCode == 'en'
                                ? ColorConstants.primaryColor
                                : ColorConstants.white,
                            textColor: localeProvider.selectedLocale.languageCode == 'en'
                                ? ColorConstants.white
                                : ColorConstants.primaryColor,
                            showShadow: true,
                            onPressed: () {
                              localeProvider.setLocale(const Locale('en'));
                            },
                          ),
                          CustomFilledButton(
                            title: 'العربية',
                            width: size.width * 0.4,
                            height: 30.sp,
                            fontSize: FontSizes.smallText,
                            btnRadius: 5.r,
                            btnColor: localeProvider.selectedLocale.languageCode == 'ar'
                                ? ColorConstants.primaryColor
                                : ColorConstants.white,
                            textColor: localeProvider.selectedLocale.languageCode == 'ar'
                                ? ColorConstants.white
                                : ColorConstants.primaryColor,
                            showShadow: true,
                            onPressed: () {
                              localeProvider.setLocale(const Locale('ar'));
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    Text(
                      localizedText(context)!.select_your_currency,
                      style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.sp),
                      child: Container(
                        width: size.width * 0.9,
                        height: 300,
                        decoration: BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: BorderRadius.circular(5.r),
                            boxShadow: [
                              BoxShadow(
                                  color: ColorConstants.textColorGrey.withOpacity(0.1),
                                  offset: Offset(0, 0),
                                  spreadRadius: 2,
                                  blurRadius: 15)
                            ]),
                        child: Scrollbar(
                          trackVisibility: true,
                          interactive: true,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: SelectLangAndCurrencyUI.availableCurrencies.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  dense: true,
                                  title: Text(
                                    SelectLangAndCurrencyUI.availableCurrencies[index],
                                    style: TextStyle(
                                      fontSize: FontSizes.extraSmallText,
                                      fontWeight:
                                      localeProvider.selectedCurrency == SelectLangAndCurrencyUI.availableCurrencies[index]
                                          ? FontWeight.w800
                                          : null,
                                    ),
                                  ),
                                  trailing:
                                  localeProvider.selectedCurrency == SelectLangAndCurrencyUI.availableCurrencies[index]
                                      ? Icon(
                                    CupertinoIcons.check_mark,
                                    size: FontSizes.smallText,
                                  )
                                      : SizedBox(),
                                  onTap: () {
                                    localeProvider.setCurrency(SelectLangAndCurrencyUI.availableCurrencies[index]);
                                  },
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomElevatedButton.solid(
                      title: localizedText(context)?.next.toUpperCase(),
                      onPressed: () async {
                        await SharedPreferencesService().setString(KeysConstants.defaultLanguage, localeProvider.selectedLocale.languageCode);
                        await SharedPreferencesService().setString(KeysConstants.defaultCurrency, localeProvider.selectedCurrency);
                        Navigator.pushReplacementNamed(context, RouteConstants.appTracking);
                      }),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
