import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_colors.dart';
import '../utils/assets_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.hasLogo = true,
    this.title,
    this.actions,
  });

  final bool hasLogo;
  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: hasLogo
          ? SvgPicture.asset(
              AssetsManager.taskIconPath,
              width: 80,
              height: 40,
            )
          : Text(
              title ?? '',
              style: TextStyle(
                color: AppColors.primary,
              ),
            ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
