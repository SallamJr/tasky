import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/extensions/extensions.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_divider.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../data/models/task.dart';
import '../controllers/tasks_cubit/tasks_cubit.dart';
import 'custom_list_view_builder.dart';

class TasksBody extends StatelessWidget {
  const TasksBody({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<TasksCubit>().tasksStream,
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

        List<MyTask> tasks = snapshot.data!.docs.map(
          (DocumentSnapshot doc) {
            Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
            MyTask task = MyTask.fromJson(data);
            return task;
          },
        ).toList();

        return ListView(
          padding: const EdgeInsets.only(
            left: Constants.defaultPadding,
            right: Constants.defaultPadding,
            top: Constants.defaultPadding,
            bottom: Constants.defaultPadding * 5,
          ),
          children: [
            tasks
                    .where(
                      (element) => element.isCompleted == false,
                    )
                    .toList()
                    .isEmpty
                ? const SizedBox.shrink()
                : CustomListViewBuilder(
                    title: 'Pending',
                    tasks: tasks
                        .where(
                          (element) => element.isCompleted == false,
                        )
                        .toList(),
                  ),
            tasks
                    .where(
                      (element) => element.isCompleted,
                    )
                    .toList()
                    .isEmpty
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      if (tasks
                          .where(
                            (element) => element.isCompleted == false,
                          )
                          .toList()
                          .isNotEmpty) ...{
                        Column(
                          children: [
                            Constants.defaultPadding.ySizedBox,
                            const CustomDivider(),
                            Constants.defaultPadding.ySizedBox,
                          ],
                        ),
                      },
                      CustomListViewBuilder(
                        title: 'Completed',
                        tasks: tasks
                            .where(
                              (element) => element.isCompleted,
                            )
                            .toList(),
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
