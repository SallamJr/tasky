import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/helper.dart';
import '../../data/models/task.dart';
import '../controllers/tasks_cubit/tasks_cubit.dart';
import 'custom_scrollable_bottom_sheet_view.dart';
import 'task_tile.dart';

class CustomListViewBuilder extends StatelessWidget {
  const CustomListViewBuilder({
    super.key,
    required this.tasks,
    required this.title,
  });

  final List<MyTask> tasks;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Constants.defaultPadding.ySizedBox,
        ...List.generate(
          tasks.length,
          (int index) {
            return TaskTile(
              task: tasks[index],
              onPressed: () {
                context.read<TasksCubit>().setController(
                      text: tasks[index].title,
                    );
                Helper.showBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  child: CustomScrollableBottomSheetView(
                    formKey: context.read<TasksCubit>().titleFormKey,
                    title: 'Update Task',
                    controller: context.read<TasksCubit>().titleController,
                    hintText: 'Enter Task Title',
                    buttonText: 'Update',
                    validator: (value) => Helper.textValidator(
                      value: value,
                    ),
                    onPressed: () {
                      final updatedTask = tasks[index].copyWith(
                        title: context.read<TasksCubit>().titleController.text,
                        createdAt: DateTime.now(),
                      );
                      context.read<TasksCubit>().updateTask(
                            task: updatedTask,
                          );
                      context.pop();
                    },
                  ),
                );
              },
              onChanged: (value) {
                context.read<TasksCubit>().updateTask(
                      updateStatus: true,
                      task: tasks[index].copyWith(
                        isCompleted: value,
                        createdAt: DateTime.now(),
                      ),
                    );
              },
            );
          },
        ),
      ],
    );
  }
}
