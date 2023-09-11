import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _selectedLocale = const Locale('en');
  String _selectedCurrency = 'KWD';
  Country _selectedCountry = Country.from(json: {
    "e164_cc": "965",
    "iso2_cc": "KW",
    "e164_sc": 0,
    "geographic": true,
    "level": 1,
    "name": "Kuwait",
    "example": "50012345",
    "display_name": "Kuwait(KW) [+965]",
    "full_example_with_plus_sign": "+96550012345",
    "display_name_no_e164_cc": "Kuwait(KW)",
    "e164_key": "965 - KW - 0"
  });

  Locale get selectedLocale => _selectedLocale;

  String get selectedCurrency => _selectedCurrency;

  Country get selectedCountry => _selectedCountry;

  setLocale(Locale locale) {
    _selectedLocale = locale;
    notifyListeners();
  }

  setCurrency(String currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }

  setCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }
}
