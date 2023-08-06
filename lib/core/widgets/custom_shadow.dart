import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomShadow extends StatelessWidget {
  const CustomShadow({
    super.key,
    this.shadowValue = 55,
    this.width,
    this.height,
  });

  final int shadowValue;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.black.withOpacity(
        shadowValue / 100,
      ),
    );
  }
}
