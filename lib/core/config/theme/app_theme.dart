

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';

enum AppTheme {
  lightTheme, darkTheme
}

class AppThemes {
  static final appThemeData = {
    //create the dark theme
    //create the light theme
    AppTheme.darkTheme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColor.primaryColor,
          secondary: AppColor.primaryColor
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColor.primaryColor,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light
        ),
      ),
      useMaterial3: true,
      brightness: Brightness.light,
      dividerColor: AppColor.borderColor,
      fontFamily: 'Geist',
    )
  };
}