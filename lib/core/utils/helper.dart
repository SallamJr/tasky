import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/extensions/extensions.dart';
import 'app_colors.dart';
import 'app_strings.dart';
import 'app_text_styles.dart';
import 'constants.dart';

enum SnackBarStatus { success, error, warning }

enum MyScrollPosition { initial, top, bottom }

const Set<MaterialState> interactiveStates = <MaterialState>{
  MaterialState.selected,
};

class Helper {
  static Color getSnackBarColor(SnackBarStatus snackBarStatus) {
    late Color bgColor;
    if (snackBarStatus == SnackBarStatus.success) {
      bgColor = AppColors.green;
    } else if (snackBarStatus == SnackBarStatus.error) {
      bgColor = AppColors.red;
    } else {
      bgColor = AppColors.yellow;
    }
    return bgColor;
  }

  static Future<void> showBottomSheet({
    required BuildContext context,
    required Widget child,
    bool isScrollControlled = false,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            Constants.borderRadius,
          ),
        ),
      ),
      builder: (context) {
        return child;
      },
    );
  }

  static showCustomSnackBar({
    required BuildContext context,
    required String message,
    required SnackBarStatus snackBarStatus,
  }) {
    Color bgColor = getSnackBarColor(snackBarStatus);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        content: Text(
          message,
          style: AppTextStyles.hintTextStyle.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  static Future<void> showCustomDialog({
    required BuildContext context,
    required String icon,
    required String title,
    required String description,
    bool success = true,
    Widget? child,
  }) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.secondary,
        contentPadding: const EdgeInsets.only(
          top: Constants.defaultPadding / 2,
          right: Constants.defaultPadding / 2,
          left: Constants.defaultPadding / 2,
          bottom: Constants.defaultPadding,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CircleAvatar(
                    radius: 12,
                    backgroundColor:
                        success ? AppColors.secondary : AppColors.red,
                    child: Icon(
                      Icons.clear,
                      size: 16,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: SvgPicture.asset(
                icon,
                width: 50,
                height: 50,
              ),
            ),
            Constants.defaultPadding.ySizedBox,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.defaultPadding / 2,
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: AppTextStyles.appBarTextStyle.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  (Constants.defaultPadding / 2).ySizedBox,
                  Text(
                    description,
                    style: AppTextStyles.hintTextStyle.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            child ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  static Future<void> showCustomAlertDialog({
    required BuildContext context,
    required String title,
    required Function() onRejectPressed,
    required Function() onAcceptPressed,
  }) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: AppTextStyles.buttonTextStyle,
        ),
        actions: [
          TextButton(
            onPressed: onRejectPressed,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.red,
            ),
            child: const Text(AppStrings.no),
          ),
          TextButton(
            onPressed: onAcceptPressed,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.green,
            ),
            child: const Text(AppStrings.yes),
          ),
        ],
      ),
    );
  }

  static Future<void> showCustomDialogWidget({
    required BuildContext context,
    required Widget child,
  }) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.secondary,
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            child,
          ],
        ),
      ),
    );
  }

  static Future<void> callLaunchUrl({required String url}) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }

  static Future<DateTime?> datePickerDialog({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    bool isPast = false,
    bool filter = false,
  }) {
    initialDate = initialDate ?? DateTime.now();

    if (filter) {
      return showMonthPicker(
        context: context,
        roundedCornersRadius: Constants.borderRadius / 2,
        initialDate: initialDate,
        firstDate: isPast
            ? DateTime(
                DateTime.now().year - 15,
              )
            : firstDate ?? initialDate,
        lastDate: lastDate ??
            DateTime(
              DateTime.now().year + 15,
            ),
      );
    } else {
      return showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: isPast
            ? DateTime(
                DateTime.now().year - 15,
              )
            : firstDate ?? initialDate,
        lastDate: lastDate ??
            DateTime(
              DateTime.now().year + 15,
            ),
        initialEntryMode: DatePickerEntryMode.calendar,
        confirmText: AppStrings.confirm,
        cancelText: AppStrings.cancel,
      );
    }
  }

  static Future<TimeOfDay?> timePickerDialog({
    required BuildContext context,
    required TimeOfDay initialTime,
  }) {
    return showTimePicker(
      context: context,
      initialTime: initialTime,
      confirmText: AppStrings.confirm,
      cancelText: AppStrings.cancel,
    );
  }

  static bool checkUserStatus(String status) {
    bool authenticated = false;
    if (status == AppStrings.authStateInitial) {
      authenticated = false;
    } else if (status == AppStrings.authStateAuthenticated) {
      authenticated = true;
    } else if (status == AppStrings.authStateGuest) {
      authenticated = true;
    } else if (status == AppStrings.authStateLogout) {
      authenticated = false;
    } else {
      authenticated = false;
    }
    return authenticated;
  }

  static TextStyle getNavBarLabelStyle({
    required Set<MaterialState> states,
  }) {
    if (states.any(interactiveStates.contains)) {
      return TextStyle(
        color: AppColors.white,
        fontSize: 12,
      );
    } else {
      return TextStyle(
        color: AppColors.primary,
        fontSize: 12,
      );
    }
  }

  static IconThemeData getNavBarIconStyle({
    required Set<MaterialState> states,
  }) {
    if (states.any(interactiveStates.contains)) {
      return IconThemeData(
        color: AppColors.white,
      );
    } else {
      return IconThemeData(
        color: AppColors.primary,
      );
    }
  }

  static Color getRadioColor({
    required Set<MaterialState> states,
  }) {
    if (states.any(interactiveStates.contains)) {
      return AppColors.primary;
    } else {
      return AppColors.white;
    }
  }

  static String creatId() {
    const uuid = Uuid();
    return uuid.v4();
  }

  static bool emailValid({
    required String email,
  }) =>
      RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(
        email,
      );

  static String? emailValidator({
    required String? email,
  }) {
    if (email == null) {
      return AppStrings.emailIsRequired;
    } else if (email.isEmpty) {
      return AppStrings.emailIsRequired;
    } else {
      final bool isEmailValid = emailValid(email: email);
      if (isEmailValid) {
        return null;
      } else {
        return AppStrings.enterValidEmail;
      }
    }
  }

  static String? passwordValidator({
    required String? password,
  }) {
    if (password == null) {
      return AppStrings.passwordIsRequired;
    } else if (password.isEmpty) {
      return AppStrings.passwordIsRequired;
    } else {
      if (password.length > 7) {
        return null;
      } else {
        return AppStrings.passwordLimit;
      }
    }
  }

  static String? textValidator({
    required String? value,
  }) {
    if (value == null) {
      return AppStrings.fieldIsRequired;
    } else if (value.isEmpty) {
      return AppStrings.fieldIsRequired;
    } else {
      return null;
    }
  }
}
