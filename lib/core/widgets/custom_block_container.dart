import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../extensions/extensions.dart';

class CustomBlockContainer extends StatelessWidget {
  const CustomBlockContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: context.height * 0.48,
      child: Container(
        width: 50,
        height: 30,
        color: AppColors.black,
      ),
    );
  }
}
