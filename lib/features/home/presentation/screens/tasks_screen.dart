import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_clickable_detector.dart';
import '../../../../core/widgets/custom_svg_asset_picture.dart';
import '../controllers/profile_cubit/profile_cubit.dart';
import '../controllers/tasks_cubit/tasks_cubit.dart';
import '../widgets/custom_scrollable_bottom_sheet_view.dart';
import '../widgets/tasks_body.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            hasLogo: false,
            title: context.read<TasksCubit>().state.selectedProject!.title,
            actions: context.read<ProfileCubit>().email.isNotEmpty
                ? context.read<ProfileCubit>().email !=
                        context.read<TasksCubit>().state.selectedProject!.owner!
                    ? null
                    : [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Constants.defaultPadding / 2,
                          ),
                          child: CustomClickableDetector(
                            borderRadius: Constants.borderRadius,
                            onPressed: () => context.push(
                              routeName: Routes.projectSettingsRoute,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                Constants.defaultPadding / 1.2,
                              ),
                              child: CustomSvgAssetPicture(
                                width: 22,
                                height: 22,
                                color: AppColors.white,
                                assetName: AssetsManager.settingsIconPath,
                              ),
                            ),
                          ),
                        ),
                      ]
                : null,
          ),
          body: const TasksBody(),
          floatingActionButton: context.read<ProfileCubit>().email !=
                  context.read<TasksCubit>().state.selectedProject!.owner
              ? null
              : FloatingActionButton(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.white,
                  child: const CustomSvgAssetPicture(
                    assetName: AssetsManager.plusIconPath,
                  ),
                  onPressed: () {
                    context.read<TasksCubit>().resetController();
                    Helper.showBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      child: CustomScrollableBottomSheetView(
                        formKey: context.read<TasksCubit>().titleFormKey,
                        title: 'Create Task',
                        controller: context.read<TasksCubit>().titleController,
                        hintText: 'Enter Task Title',
                        buttonText: 'Create',
                        validator: (value) => Helper.textValidator(
                          value: value,
                        ),
                        onPressed: () {
                          context.read<TasksCubit>().createTask();
                          context.pop();
                        },
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
