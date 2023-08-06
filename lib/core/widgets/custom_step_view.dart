import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import 'custom_border.dart';
import 'custom_svg_asset_picture.dart';

class CustomStepView extends StatelessWidget {
  const CustomStepView({
    super.key,
    required this.title,
    required this.icon,
    this.selected = false,
  });

  final String title;
  final String icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.defaultPadding,
      ),
      child: Column(
        children: [
          CustomBorder(
            isCircle: selected,
            borderColor: selected ? AppColors.primary : AppColors.transparent,
            child: CustomSvgAssetPicture(
              assetName: icon,
            ),
          ),
          (Constants.defaultPadding / 2).ySizedBox,
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
