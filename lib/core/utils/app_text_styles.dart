import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  );
  static TextStyle hintTextStyle = TextStyle(
    fontSize: 14.0,
    color: AppColors.lightGrey,
    fontWeight: FontWeight.w600,
  );
  static TextStyle appBarTextStyle = TextStyle(
    fontSize: 24.0,
    color: AppColors.white,
    fontWeight: FontWeight.w600,
  );
  static TextStyle underLineTextStyle = TextStyle(
    fontSize: 14.0,
    color: AppColors.blue,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.blue,
  );
}
