import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_svg_asset_picture.dart';
import '../controllers/nav_bar_cubit/nav_bar_cubit.dart';

class NavBarBody extends StatelessWidget {
  const NavBarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        Constants.borderRadius,
      ),
      child: NavigationBar(
        selectedIndex: context.watch<NavBarCubit>().state.index,
        onDestinationSelected: (index) =>
            context.read<NavBarCubit>().changeSelectedIndex(
                  index: index,
                ),
        destinations: [
          NavigationDestination(
            icon: CustomSvgAssetPicture(
              width: 20,
              height: 20,
              assetName: AssetsManager.homeIconPath,
              color: AppColors.primary,
            ),
            selectedIcon: CustomSvgAssetPicture(
              width: 20,
              height: 20,
              assetName: AssetsManager.homeIconPath,
              color: AppColors.white,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: CustomSvgAssetPicture(
              width: 20,
              height: 20,
              assetName: AssetsManager.inboxIconPath,
              color: AppColors.primary,
            ),
            selectedIcon: CustomSvgAssetPicture(
              width: 20,
              height: 20,
              assetName: AssetsManager.inboxIconPath,
              color: AppColors.white,
            ),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: CustomSvgAssetPicture(
              width: 20,
              height: 20,
              assetName: AssetsManager.profileIconPath,
              color: AppColors.primary,
            ),
            selectedIcon: CustomSvgAssetPicture(
              width: 20,
              height: 20,
              assetName: AssetsManager.profileIconPath,
              color: AppColors.white,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
