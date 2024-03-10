import 'package:rider/data/constants/constants.dart';
import 'package:rider/helpers/cache_helper.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class MyTheme {
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      useMaterial3: false,
      fontFamily: CacheHelper.getString(key: "lang") == "en" ? Fonts.arabic : Fonts.arabic,
      primarySwatch: MyColors.mainColorSwatch,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        foregroundColor: MyColors.mainColor,
        elevation: 0,
        color: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
    );
  }

  static Widget loadingWidget({Color? color, double? width}) => Center(
          child: CircularProgressIndicator(
        color: color ?? Colors.white,
        strokeWidth: width ?? 4.0,
      ));
}

Gradient get linearGradientForCard {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [const Color(0xFF98C1FF).withOpacity(0.26), const Color(0xFF1854B0).withOpacity(0.26)],
  );
}

Gradient get linearGradientForContactWithProvider {
  return const LinearGradient(
    begin: Alignment(0.0, -2.49),
    end: Alignment.bottomCenter,
    colors: [Color(0xFF98C1FF), Color(0xFF1552AE)],
  );
}
