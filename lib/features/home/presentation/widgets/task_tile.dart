import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_clickable_detector.dart';
import '../../../../core/widgets/custom_list_tile.dart';
import '../../../../core/widgets/custom_svg_asset_picture.dart';
import '../../data/models/task.dart';
import '../controllers/profile_cubit/profile_cubit.dart';
import '../controllers/tasks_cubit/tasks_cubit.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    this.onChanged,
    this.onPressed,
  });

  final MyTask task;
  final Function(bool?)? onChanged;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Constants.defaultPadding,
      ),
      child: CustomListTile(
        onPressed: onPressed,
        borderRadius: Constants.borderRadius,
        leading: Checkbox.adaptive(
          checkColor: AppColors.white,
          activeColor: AppColors.primary,
          value: task.isCompleted ? true : false,
          onChanged: onChanged,
        ),
        trailing: context.read<ProfileCubit>().state.user.email !=
                context.read<TasksCubit>().state.selectedProject!.owner
            ? null
            : CustomClickableDetector(
                borderRadius: Constants.textFieldBorderRadius / 10,
                onPressed: () {
                  return context.read<TasksCubit>().deleteTask(
                        task: task,
                      );
                },
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
        title: task.title,
        lineThrough: task.isCompleted ? true : false,
        color: AppColors.white,
        tileColor: AppColors.secondary,
      ),
    );
  }
}
