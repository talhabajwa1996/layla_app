import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ColorConstants.dart';

class AppTheme {
  ThemeData buildTheme(brightness) {
    var baseTheme = ThemeData(
      scaffoldBackgroundColor: ColorConstants.baseColor,
      splashColor: ColorConstants.dullWhite.withOpacity(0.5),
      appBarTheme: const AppBarTheme(
          surfaceTintColor: ColorConstants.baseColor,
          backgroundColor: ColorConstants.baseColor,
          shadowColor: ColorConstants.baseColor),
      colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.primaryColor),
      useMaterial3: true,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    );
  }
}
