import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/controllers/profile_cubit/profile_cubit.dart';
import '../extensions/extensions.dart';
import '../utils/app_colors.dart';
import '../utils/assets_manager.dart';
import '../utils/constants.dart';
import 'custom_clickable_detector.dart';
import 'custom_svg_asset_picture.dart';

class CustomProfileIconView extends StatelessWidget {
  const CustomProfileIconView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomClickableDetector(
      onPressed: () => BlocProvider.of<ProfileCubit>(context)
          .uploadUserImage(),
      child: Container(
        height: context.height * 0.2,
        padding: const EdgeInsets.all(
          Constants.defaultPadding * 2,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.secondary,
        ),
        child: CustomSvgAssetPicture(
          assetName: AssetsManager.profileIconPath,
          color: AppColors.white,
        ),
      ),
    );
  }
}
