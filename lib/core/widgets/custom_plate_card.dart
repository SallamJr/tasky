import 'package:flutter/material.dart';

import '../utils/app_strings.dart';
import '/core/extensions/extensions.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import 'custom_cached_network_image.dart';
import 'custom_text_button.dart';

class CustomPlateCard extends StatelessWidget {
  const CustomPlateCard({
    super.key,
    this.viewOnly = true,
  });

  final bool viewOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Constants.defaultPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomCachedNetworkImage(
            url: AppStrings.imgUrl,
          ),
          Constants.defaultPadding.xSizedBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Plate Name',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.white,
                ),
              ),
              viewOnly
                  ? const SizedBox.shrink()
                  : Row(
                      children: [
                        CustomTextButton(
                          text: 'Delete',
                          underline: false,
                          color: AppColors.white,
                          onPressed: () {},
                        ),
                        Text(
                          '|',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.white,
                          ),
                        ),
                        CustomTextButton(
                          text: 'Edit',
                          underline: false,
                          color: AppColors.white,
                          onPressed: () {},
                        ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
