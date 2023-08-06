import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/extensions/extensions.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../data/models/project.dart';
import '../controllers/profile_cubit/profile_cubit.dart';
import '../controllers/projects_cubit/projects_cubit.dart';
import '../controllers/tasks_cubit/tasks_cubit.dart';
import 'custom_scrollable_bottom_sheet_view.dart';
import 'project_title.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<ProjectsCubit>().projectsStream,
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
        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.defaultPadding,
            vertical: Constants.defaultPadding * 2,
          ),
          children: snapshot.data!.docs.map<Widget>(
            (DocumentSnapshot doc) {
              Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
              Project project = Project.fromJson(data);

              return ProjectTile(
                project: project,
                onLongPress: context.read<ProfileCubit>().email != project.owner
                    ? null
                    : () {
                        context.read<ProjectsCubit>().setController(
                              text: project.title,
                            );
                        Helper.showBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          child: CustomScrollableBottomSheetView(
                            formKey: context.read<ProjectsCubit>().titleFormKey,
                            title: 'Update Project',
                            controller:
                                context.read<ProjectsCubit>().titleController,
                            hintText: 'Enter Project Title',
                            buttonText: 'Update',
                            validator: (value) => Helper.textValidator(
                              value: value,
                            ),
                            onPressed: () {
                              final updatedProject = project.copyWith(
                                title: context
                                    .read<ProjectsCubit>()
                                    .titleController
                                    .text,
                                createdAt: DateTime.now(),
                              );
                              context.read<ProjectsCubit>().updateProject(
                                    project: updatedProject,
                                  );
                              context.pop();
                            },
                          ),
                        );
                      },
                onPressed: () {
                  context.read<TasksCubit>().changeSelectedProject(
                        project: project,
                      );
                  context.push(
                    routeName: Routes.tasksRoute,
                  );
                },
              );
            },
          ).toList(),
        );
      },
    );
  }
}
