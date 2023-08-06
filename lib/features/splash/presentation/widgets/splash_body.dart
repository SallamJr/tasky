import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_svg_asset_picture.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CustomSvgAssetPicture(
          assetName: AssetsManager.taskIconPath,
          width: 100,
          height: 100,
        ),
        (Constants.horizontalPadding / 2).ySizedBox,
        const Text(
          AppStrings.appName,
          textAlign: TextAlign.center,
        ),
      ],
    ).animate(
      delay: 800.ms,
      effects: [
        const FadeEffect(),
        const ShimmerEffect(),
        const ScaleEffect(
          curve: Curves.fastEaseInToSlowEaseOut,
        ),
      ],
    ).shake();
  }
}
