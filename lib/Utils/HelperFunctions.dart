import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:is_first_run/is_first_run.dart';

class HelperFunctions {

  ///check First Run
  Future<bool> checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun();
   return ifr;
  }

  String getInitials(String name) {
    // Split the name into words
    List<String> words = name.split(" ");

    // Initialize a variable to store the initials
    String initials = "";

    // Iterate through the words and add the first letter of each word to the initials
    for (String word in words) {
      if (word.isNotEmpty) {
        initials += word[0];
      }
    }

    return initials;
  }

}

AppLocalizations? localizedText(context) => AppLocalizations.of(context);
