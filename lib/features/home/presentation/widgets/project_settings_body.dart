import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/assets_manager.dart';
import 'package:tasky/core/widgets/custom_clickable_detector.dart';
import 'package:tasky/core/widgets/custom_svg_asset_picture.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/widgets/custom_bg_container_view.dart';
import '../../../../core/widgets/custom_list_tile_view.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../data/models/project.dart';
import '../controllers/projects_cubit/projects_cubit.dart';
import '../controllers/tasks_cubit/tasks_cubit.dart';
import 'custom_scrollable_bottom_sheet_view.dart';

class ProjectSettingsBody extends StatelessWidget {
  const ProjectSettingsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.defaultPadding,
        vertical: Constants.defaultPadding,
      ),
      children: [
        CustomBgContainerView(
          padding: EdgeInsets.zero,
          child: CustomListTileView(
            onPressed: () {
              context.read<ProjectsCubit>().resetController();
              Helper.showBottomSheet(
                context: context,
                isScrollControlled: true,
                child: CustomScrollableBottomSheetView(
                  formKey: context.read<ProjectsCubit>().collaboratorFormKey,
                  title: 'Add Collaborator',
                  controller:
                      context.read<ProjectsCubit>().collaboratorController,
                  hintText: 'enter collaborator email',
                  keyboardType: TextInputType.emailAddress,
                  buttonText: 'Add',
                  validator: (email) => Helper.emailValidator(email: email),
                  onPressed: () {
                    context.read<ProjectsCubit>().updateCollaborators(
                          project:
                              context.read<TasksCubit>().state.selectedProject!,
                        );
                    context.pop();
                  },
                ),
              );
            },
            trailing: CustomSvgAssetPicture(
              width: 20,
              height: 20,
              color: AppColors.white,
              assetName: AssetsManager.arrowRightIconPath,
            ),
            title: 'Add Collaborator',
          ),
        ),
        ExpansionTile(
          title: const Text(
            'Collaborators',
            style: TextStyle(
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          childrenPadding: const EdgeInsets.only(
            left: Constants.defaultPadding / 2,
            right: Constants.defaultPadding / 2,
            bottom: Constants.defaultPadding,
          ),
          trailing: CustomSvgAssetPicture(
            width: 20,
            height: 20,
            color: AppColors.white,
            assetName: AssetsManager.arrowRightIconPath,
          ),
          collapsedBackgroundColor: AppColors.secondary,
          backgroundColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              Constants.borderRadius / 2,
            ),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              Constants.borderRadius / 2,
            ),
          ),
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: context.read<TasksCubit>().collaboratorsStream,
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
                Project project = Project.fromJson(data);
                List<String>? collaborators = project.collaborators;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    collaborators!.length,
                    (index) => CustomListTileView(
                      title: '${index + 1} - ${collaborators[index]}',
                      trailing: project.owner != collaborators[index]
                          ? CustomClickableDetector(
                              onPressed: () {
                                BlocProvider.of<ProjectsCubit>(context)
                                    .removeCollaborator(
                                  project: project,
                                  collaborator: collaborators[index],
                                );
                                BlocProvider.of<TasksCubit>(context)
                                    .changeSelectedProject(
                                  project: project,
                                );
                              },
                              child: CustomSvgAssetPicture(
                                width: 20,
                                height: 20,
                                color: AppColors.red,
                                assetName: AssetsManager.trashIconPath,
                              ),
                            )
                          : null,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
