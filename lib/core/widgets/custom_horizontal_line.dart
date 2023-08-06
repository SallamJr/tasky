import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomHorizontalLine extends StatelessWidget {
  const CustomHorizontalLine({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              color: color ?? AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
