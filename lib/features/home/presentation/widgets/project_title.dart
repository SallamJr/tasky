import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_clickable_detector.dart';
import '../../../../core/widgets/custom_list_tile.dart';
import '../../../../core/widgets/custom_svg_asset_picture.dart';
import '../../data/models/project.dart';
import '../controllers/profile_cubit/profile_cubit.dart';
import '../controllers/projects_cubit/projects_cubit.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({
    super.key,
    required this.project,
    this.onChanged,
    this.onPressed,
    this.onLongPress,
  });

  final Project project;
  final Function(bool?)? onChanged;
  final Function()? onPressed;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Constants.defaultPadding,
      ),
      child: CustomListTile(
        onPressed: onPressed,
        onLongPress: onLongPress,
        borderRadius: Constants.borderRadius,
        title: project.title,
        lineThrough: project.isCompleted ? true : false,
        color: AppColors.white,
        tileColor: AppColors.secondary,
        trailing: context.read<ProfileCubit>().email != project.owner
            ? null
            : CustomClickableDetector(
                borderRadius: Constants.textFieldBorderRadius / 10,
                onPressed: () => context.read<ProjectsCubit>().deleteProject(
                      project: project,
                    ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Constants.defaultPadding / 5,
                    horizontal: Constants.defaultPadding / 5,
                  ),
                  child: CustomSvgAssetPicture(
                    assetName: AssetsManager.trashIconPath,
                    color: AppColors.red,
                  ),
                ),
              ),
      ),
    );
  }
}
