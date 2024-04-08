import 'dart:math';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:native_exif/native_exif.dart';
import 'dart:io';

class HelperFunctions {
  ///check First Run
  Future<bool> checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun();
    return ifr;
  }

  String getInitials(String? name) {
    // Split the name into words
    List<String> words = name!.split(" ");

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

  String calculateDiscount(double price, double discountedPrice) {
    var cal = ((price - discountedPrice) / price) * 100;
    String saved = cal.round().toString();
    return saved;
  }

  convertDate(value) {
    String dateString = value;
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);
    // Define a custom date format
    // final DateFormat formatter = DateFormat.yMMMMd();
    // Format the DateTime object as a custom date string
    String formattedDate = DateFormat("MMM d, yyyy").format(dateTime);
    return formattedDate;
  }

  convertTime(value) {
    String dateTimeString = value;
    // Parse the string into a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    // Format the time
    String formattedTime = DateFormat("h:mma").format(dateTime);
    return formattedTime;
  }

  Future<File> compressImage(File file) async {
    // Compress the image
    print("Compressing the image");
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, '${file.parent.path}/${getRandomString(4)}.jpg', // Provide the path for the compressed image
        quality: 50, // Adjust the quality as per your requirements (0 - 100)
        minWidth: 800, // Set the target width
        minHeight: 600,
        keepExif: true);
    print("Path:: ${compressedImage?.path}");
    Exif exif = await Exif.fromPath(compressedImage!.path);
    // attributes = await exif!.getAttributes();
    final dateFormat = DateFormat('yyyy:MM:dd HH:mm:ss');
    await exif.writeAttribute('DateTimeOriginal', dateFormat.format(DateTime.now()));
    return File(compressedImage.path);
  }

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


}

AppLocalizations? localizedText(context) => AppLocalizations.of(context);
