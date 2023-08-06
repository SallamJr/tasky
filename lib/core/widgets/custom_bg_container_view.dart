import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';

class CustomBgContainerView extends StatelessWidget {
  const CustomBgContainerView({
    super.key,
    this.padding,
    required this.child,
  });
  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: Constants.defaultPadding,
            vertical: Constants.defaultPadding / 1.2,
          ),
      margin: const EdgeInsets.only(
        bottom: Constants.defaultPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(
          Constants.borderRadius / 2,
        ),
      ),
      child: child,
    );
  }
}
