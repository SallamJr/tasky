import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';

class CustomBorder extends StatelessWidget {
  const CustomBorder({
    super.key,
    required this.child,
    this.borderRadius,
    this.borderColor,
    this.isCircle = false,
  });

  final double? borderRadius;
  final Color? borderColor;
  final Widget? child;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isCircle
          ? const EdgeInsets.all(
              Constants.defaultPadding / 2,
            )
          : EdgeInsets.zero,
      decoration: BoxDecoration(
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        border: Border.all(
          color: borderColor ?? AppColors.primary,
        ),
        borderRadius: isCircle
            ? null
            : BorderRadius.circular(
                borderRadius ?? Constants.borderRadius / 2,
              ),
      ),
      child: child,
    );
  }
}
