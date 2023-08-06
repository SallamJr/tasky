import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/helper.dart';

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
    hintColor: AppColors.grey,
    brightness: Brightness.dark,
    indicatorColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.black,
    fontFamily: AppStrings.fontFamily,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        height: 1.5,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.primary,
      systemOverlayStyle: const SystemUiOverlayStyle(
        // statusBarColor: AppColors.primary,
        statusBarBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: true,
      ),
      titleTextStyle: const TextStyle(
        fontSize: 22.0,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w500,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.secondary,
      indicatorColor: AppColors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: MaterialStateProperty.resolveWith(
        (states) => Helper.getNavBarLabelStyle(states: states),
      ),
      iconTheme: MaterialStateProperty.resolveWith(
        (states) => Helper.getNavBarIconStyle(states: states),
      ),
    ),
  );
}
