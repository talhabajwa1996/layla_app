import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:layla_app_dev/Controllers/LocaleProvider.dart';
import 'package:layla_app_dev/Utils/Constants/AppIcons.dart';
import 'package:layla_app_dev/Utils/Constants/ImageConstants.dart';
import 'package:layla_app_dev/Utils/Constants/RouteConstants.dart';
import 'package:layla_app_dev/Utils/HelperFunctions.dart';
import 'package:layla_app_dev/Widgets/BottomSheets/CustomBottomSheet.dart';
import 'package:layla_app_dev/Widgets/Appbars/LogoAppBar.dart';
import 'package:provider/provider.dart';
import '../../Utils/Constants/ColorConstants.dart';
import '../../Widgets/Buttons/CustomElevatedButton.dart';

class SelectLangAndCurrencyUI extends StatelessWidget {
  const SelectLangAndCurrencyUI({super.key});

  static const List<String> availableCurrencies = [
    "KWD",
    "SAR",
    "AED",
    "QAR",
    "OMR",
    "BHD",
    "USD",
    "EUR"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: logoAppBar(),
      body: Stack(
        children: [
          Image.asset(ImageConstants.worldBg),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 150),
                Text(
                  localizedText(context).welcome_to_layla,
                  style: const TextStyle(
                      color: ColorConstants.textColorGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const SizedBox(height: 80),
                Consumer<LocaleProvider>(
                    builder: (context, localeProvider, child) {
                  return Column(
                    children: [
                      ListTile(
                        trailing: const Icon(AppIcons.arrowForward, size: 16),
                        title:  Text(localizedText(context).country),
                        subtitle: Text(
                          localeProvider.selectedCountry.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onTap: () => showCountryPicker(
                          context: context,
                          exclude: ['IL'],
                          showPhoneCode: false,
                          onSelect: (Country country) {
                            localeProvider.setCountry(country);
                          },
                        ),
                      ),
                      ListTile(
                        trailing: const Icon(AppIcons.arrowForward, size: 16),
                        title:  Text(localizedText(context).language),
                        subtitle: Text(
                          localeProvider.selectedLocale.languageCode == 'en'
                              ? 'English'
                              : localeProvider.selectedLocale.languageCode ==
                                      'ar'
                                  ? 'العربية'
                                  : "",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          customBottomSheet(context,
                              title: localizedText(context).select_language,
                              initialIndex: localeProvider.selectedLocale ==
                                      const Locale('en')
                                  ? 0
                                  : 1,
                              onSelectedItemChanged: (index) => index == 0
                                  ? localeProvider.setLocale(const Locale('en'))
                                  : localeProvider
                                      .setLocale(const Locale('ar')),
                              selectionOptions: ['English', 'العربية']);
                        },
                      ),
                      ListTile(
                        trailing: const Icon(AppIcons.arrowForward, size: 16),
                        title:  Text(localizedText(context).currency),
                        subtitle: Text(
                          localeProvider.selectedCurrency,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          customBottomSheet(context,
                              title: localizedText(context).select_currency,
                              initialIndex: availableCurrencies.indexWhere(
                                  (element) =>
                                      element ==
                                      localeProvider.selectedCurrency),
                              onSelectedItemChanged: (index) => localeProvider
                                  .setCurrency(availableCurrencies[index]),
                              selectionOptions: availableCurrencies);
                        },
                      ),
                    ],
                  );
                }),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: CustomElevatedButton.solid(
                      title: localizedText(context).go_shopping.toUpperCase(),
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, RouteConstants.bottomBar)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
