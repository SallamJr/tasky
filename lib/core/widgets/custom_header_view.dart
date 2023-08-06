import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';

class CustomHeaderView extends StatelessWidget {
  const CustomHeaderView({
    super.key,
    required this.title,
    required this.value,
    this.horizontal = false,
  });

  final String title;
  final String value;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    return horizontal
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: Constants.defaultPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primary,
                ),
              ),
              Constants.defaultPadding.ySizedBox,
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.white,
                ),
              ),
              Constants.defaultPadding.ySizedBox,
            ],
          );
  }
}
