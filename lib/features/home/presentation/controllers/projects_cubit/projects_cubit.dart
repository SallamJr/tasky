import 'dart:developer' as dev;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/constants.dart';
import '../../../data/models/project.dart';
import '../../../data/repositories/projects_repository.dart';

part 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit({
    required this.projectsRepository,
    required this.uuid,
  }) : super(
          ProjectsState.initial(),
        );

  final ProjectsRepository projectsRepository;
  final Uuid uuid;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController collaboratorController = TextEditingController();

  final GlobalKey<FormState> titleFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> collaboratorFormKey = GlobalKey<FormState>();

  Stream<QuerySnapshot<Map<String, dynamic>>> get projectsStream =>
      projectsRepository.projectsStream;

  void resetController() {
    titleController.clear();
    collaboratorController.clear();
  }

  void resetCubit() {
    resetController();
    emit(
      ProjectsState.initial(),
    );
  }

  void setController({
    required String text,
  }) {
    titleController.text = text;
  }

  Future<void> removeCollaborator({
    required Project project,
    required String collaborator,
  }) async {
    List<String> collaborators = project.collaborators ?? [];
    dev.log(
      'Collaborator: $collaborator',
    );
    if (!collaborators.contains(
      collaborator,
    )) {
      return;
    }
    collaborators.remove(
      collaborator,
    );
    dev.log(
      'Collaborators: $collaborators',
    );
    Project newProject = Project(
      id: project.id,
      title: project.title,
      isCompleted: project.isCompleted,
      collaborators: collaborators,
      owner: project.owner,
      createdAt: project.createdAt,
    );
    dev.log(
      'Project: $newProject',
    );
    await updateProject(
      project: newProject,
      updateStatus: true,
    );
  }

  Future<void> updateCollaborators({
    required Project project,
  }) async {
    if (!collaboratorFormKey.currentState!.validate()) {
      return;
    }
    dev.log(
      'Old Project: $project',
    );
    List<String> collaborators = project.collaborators ?? [];
    dev.log(
      'Collaborator: ${collaboratorController.text}',
    );
    if (collaborators.contains(
      collaboratorController.text,
    )) {
      return;
    }
    collaborators.add(
      collaboratorController.text,
    );
    dev.log(
      'Collaborators: $collaborators',
    );
    Project newProject = Project(
      id: project.id,
      title: project.title,
      isCompleted: project.isCompleted,
      collaborators: collaborators,
      owner: project.owner,
      createdAt: project.createdAt,
    );
    dev.log(
      'Project: $newProject',
    );
    await updateProject(
      project: newProject,
      updateStatus: true,
    );
  }

  Future<void> createProject() async {
    if (!titleFormKey.currentState!.validate()) {
      return;
    }
    emit(
      state.copyWith(status: ControllerStateStatus.updating),
    );

    Either<String, String> response = await projectsRepository.createProject(
      project: Project(
        id: uuid.v1(),
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

  Future<void> updateProject({
    required Project project,
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

    Either<String, String> response = await projectsRepository.updateProject(
      project: project,
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

  Future<void> deleteProject({
    required Project project,
  }) async {
    emit(
      state.copyWith(status: ControllerStateStatus.updating),
    );

    Either<String, String> response = await projectsRepository.deleteProject(
      project: project,
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

  Future<void> getAllProjects({
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

    Either<String, List<Project>> response =
        await projectsRepository.getAllProjects();

    emit(
      response.fold(
        (failure) => state.copyWith(
          message: failure,
          status: ControllerStateStatus.error,
        ),
        (projects) => state.copyWith(
          projects: projects,
          message: AppStrings.getAllProjectsCompletedSuccessfully,
          status: ControllerStateStatus.success,
        ),
      ),
    );
  }
}
