import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'constants.dart';

class AppTextFieldBorderStyles {
  static OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.primary,
      width: Constants.borderWidth,
    ),
    borderRadius: BorderRadius.circular(
      Constants.borderRadius,
    ),
  );
  static OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.red,
      width: Constants.borderWidth,
    ),
    borderRadius: BorderRadius.circular(
      Constants.borderRadius,
    ),
  );
}
