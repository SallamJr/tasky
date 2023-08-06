import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/constants.dart';
import '../../../data/models/project.dart';
import '../../../data/models/task.dart';
import '../../../data/repositories/tasks_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit({
    required this.tasksRepository,
    required this.uuid,
  }) : super(
          TasksState.initial(),
        );

  final TasksRepository tasksRepository;
  final Uuid uuid;

  final TextEditingController titleController = TextEditingController();

  final titleFormKey = GlobalKey<FormState>();

  Stream<DocumentSnapshot<Map<String, dynamic>>> get collaboratorsStream =>
      tasksRepository.collaboratorsStream(
        projectId: state.selectedProject!.id,
      );

  Stream<QuerySnapshot<Map<String, dynamic>>> get tasksStream =>
      tasksRepository.tasksStream(
        projectId: state.selectedProject!.id,
      );

  void resetController() {
    titleController.clear();
  }

  void resetCubit() {
    resetController();
    emit(
      TasksState.initial(),
    );
  }

  void setController({
    required String text,
  }) {
    titleController.text = text;
  }

  void changeSelectedProject({
    required Project project,
  }) {
    emit(
      state.copyWith(
        selectedProject: project,
      ),
    );
  }

  Future<void> createTask() async {
    if (!titleFormKey.currentState!.validate()) {
      return;
    }
    emit(
      state.copyWith(status: ControllerStateStatus.updating),
    );

    Either<String, String> response = await tasksRepository.createTask(
      task: MyTask(
        id: uuid.v1(),
        projectId: state.selectedProject!.id,
        title: titleController.text.trim(),
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
    );

    emit(
      response.fold(
        (failure) => state.copyWith(
          message: failure,
          status: ControllerStateStatus.error,
        ),
        (success) => state.copyWith(
          message: success,
          status: ControllerStateStatus.success,
        ),
      ),
    );
  }

  Future<void> updateTask({
    required MyTask task,
    bool updateStatus = false,
  }) async {
    if (!updateStatus) {
      if (!titleFormKey.currentState!.validate()) {
        return;
      }
    }
    emit(
      state.copyWith(status: ControllerStateStatus.updating),
    );

    Either<String, String> response = await tasksRepository.updateTask(
      task: task,
    );

    emit(
      response.fold(
        (failure) => state.copyWith(
          message: failure,
          status: ControllerStateStatus.error,
        ),
        (success) => state.copyWith(
          message: success,
          status: ControllerStateStatus.success,
        ),
      ),
    );
  }

  Future<void> deleteTask({
    required MyTask task,
  }) async {
    emit(
      state.copyWith(status: ControllerStateStatus.updating),
    );

    Either<String, String> response = await tasksRepository.deleteTask(
      task: task,
    );

    emit(
      response.fold(
        (failure) => state.copyWith(
          message: failure,
          status: ControllerStateStatus.error,
        ),
        (success) => state.copyWith(
          message: success,
          status: ControllerStateStatus.success,
        ),
      ),
    );
  }

  Future<void> getAllTasks({
    bool updating = false,
  }) async {
    if (updating) {
      emit(
        state.copyWith(
          status: ControllerStateStatus.updating,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: ControllerStateStatus.loading,
        ),
      );
    }

    Either<String, List<MyTask>> response = await tasksRepository.getAllTasks(
      projectId: state.selectedProject!.id,
    );

    emit(
      response.fold(
        (failure) => state.copyWith(
          message: failure,
          status: ControllerStateStatus.error,
        ),
        (tasks) => state.copyWith(
          tasks: tasks,
          message: AppStrings.getAllProjectsCompletedSuccessfully,
          status: ControllerStateStatus.success,
        ),
      ),
    );
  }
}
