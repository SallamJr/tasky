import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/extensions/extensions.dart';
import 'package:tasky/core/widgets/custom_cached_network_image.dart';
import 'package:tasky/core/widgets/custom_clickable_detector.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/widgets/custom_bg_container_view.dart';
import '../../../../core/widgets/custom_list_tile_view.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/widgets/custom_profile_icon_view.dart';
import '../../../../core/widgets/custom_svg_asset_picture.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/controllers/auth_repo_cubit/auth_repo_cubit.dart';
import '../controllers/profile_cubit/profile_cubit.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: BlocProvider.of<ProfileCubit>(context).userDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Error',
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CustomLoading(
              shadow: false,
            ),
          );
        }

        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromJson(data);
        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.defaultPadding,
            vertical: Constants.defaultPadding,
          ),
          children: [
            Column(
              children: [
                user.profileImage.isEmpty
                    ? const CustomProfileIconView()
                    : CustomClickableDetector(
                        onPressed: () => BlocProvider.of<ProfileCubit>(context)
                            .uploadUserImage(
                          updating: true,
                        ),
                        borderRadius: 200,
                        child: CustomCachedNetworkImage(
                          width: 200,
                          height: 200,
                          borderRadius: 200,
                          url: user.profileImage,
                          fit: BoxFit.contain,
                        ),
                      ),
              ],
            ),
            Constants.defaultPadding.ySizedBox,
            CustomBgContainerView(
              padding: EdgeInsets.zero,
              child: CustomListTileView(
                title: user.name,
              ),
            ),
            CustomBgContainerView(
              padding: EdgeInsets.zero,
              child: CustomListTileView(
                title: user.email,
              ),
            ),
            CustomBgContainerView(
              padding: EdgeInsets.zero,
              child: CustomClickableDetector(
                borderRadius: Constants.textFieldBorderRadius,
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.aboutRoute,
                ),
                child: CustomListTileView(
                  title: 'About Tasky',
                  color: AppColors.primary,
                ),
              ),
            ),
            CustomBgContainerView(
              padding: EdgeInsets.zero,
              child: CustomClickableDetector(
                borderRadius: Constants.textFieldBorderRadius,
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.developersRoute,
                ),
                child: CustomListTileView(
                  title: 'About Developers',
                  color: AppColors.primary,
                ),
              ),
            ),
            CustomBgContainerView(
              padding: EdgeInsets.zero,
              child: CustomClickableDetector(
                borderRadius: Constants.textFieldBorderRadius,
                onPressed: () {
                  Helper.showCustomAlertDialog(
                    context: context,
                    title: 'Are you sure, you want to logout?',
                    onRejectPressed: () => context.pop(),
                    onAcceptPressed: () =>
                        context.read<AuthRepoCubit>().logout(),
                  );
                },
                child: CustomListTileView(
                  title: AppStrings.logout,
                  color: AppColors.red,
                  trailing: CustomSvgAssetPicture(
                    width: 20,
                    height: 20,
                    color: AppColors.red,
                    assetName: AssetsManager.exitIconPath,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
