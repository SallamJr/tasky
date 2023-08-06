import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';

class CustomContainerView extends StatelessWidget {
  const CustomContainerView({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: Constants.defaultPadding,
            vertical: Constants.defaultPadding,
          ),
      margin: margin ??
          const EdgeInsets.only(
            bottom: Constants.defaultPadding,
          ),
      decoration: BoxDecoration(
        color: color ?? AppColors.secondary,
        borderRadius: BorderRadius.circular(
          Constants.borderRadius,
        ),
      ),
      child: child,
    );
  }
}
