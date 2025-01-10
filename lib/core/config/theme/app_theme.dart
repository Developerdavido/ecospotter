

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
          primary: AppColors.primaryColor,
          secondary: AppColors.primaryColor
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light
        ),
      ),
      useMaterial3: true,
      brightness: Brightness.light,
      dividerColor: AppColors.borderColor,
      fontFamily: 'Geist',
    )
  };
}