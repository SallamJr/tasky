import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    this.onPressed,
    this.onLongPress,
    this.leading,
    this.trailing,
    this.color,
    this.borderRadius,
    this.tileColor,
    this.fontSize,
    this.contentPadding,
    this.lineThrough = false,
  });

  final String title;
  final Function()? onPressed;
  final Function()? onLongPress;
  final Widget? leading;
  final Widget? trailing;
  final Color? color;
  final Color? tileColor;
  final double? borderRadius;
  final double? fontSize;
  final EdgeInsetsGeometry? contentPadding;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      onLongPress: onLongPress,
      tileColor: tileColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          borderRadius ?? Constants.textFieldBorderRadius,
        ),
      ),
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(
            vertical: Constants.defaultPadding / 3,
            horizontal: Constants.defaultPadding * 1.5,
          ),
      leading: leading,
      trailing: trailing,
      title: Text(
        title,
        style: TextStyle(
          color: color ?? AppColors.primary,
          fontSize: fontSize ?? 17,
          fontWeight: FontWeight.bold,
          decoration: lineThrough ? TextDecoration.lineThrough : null,
          decorationThickness: Constants.defaultPadding / 5,
          decorationColor: color ?? AppColors.primary,
          decorationStyle: TextDecorationStyle.solid,
        ),
      ),
    );
  }
}
