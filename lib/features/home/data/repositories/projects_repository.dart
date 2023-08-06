import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/utils/app_strings.dart';
import '../models/project.dart';

class ProjectsRepository {
  ProjectsRepository();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore storage = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get projectsStream => storage
      .collection(AppStrings.projectsCollection)
      .where(
        'collaborators',
        arrayContains: auth.currentUser!.email,
      )
      .orderBy(
        'createdAt',
        descending: true,
      )
      .snapshots();

  Future<Either<String, String>> createProject({
    required Project project,
  }) async {
    if (auth.currentUser != null && auth.currentUser!.email != null) {
      final String email = auth.currentUser!.email!;
      final List<String> collaborators = [email];
      final newProject = Project(
        id: project.id,
        title: project.title,
        isCompleted: project.isCompleted,
        collaborators: collaborators,
        owner: auth.currentUser!.email!,
        createdAt: project.createdAt,
      );
      project = newProject;
    }
    try {
      await storage
          .collection(AppStrings.projectsCollection)
          .doc(project.id)
          .set(
            project.toJson(),
          );
      return const Right(
        AppStrings.projectCreatedSuccessfully,
      );
    } on FirebaseException catch (e) {
      return Left(
        '${AppStrings.createProjectFailed} ${e.code}',
      );
    } catch (e) {
      return Left(
        '${AppStrings.createProjectFailed} $e',
      );
    }
  }

  Future<Either<String, String>> updateProject({
    required Project project,
  }) async {
    try {
      await storage
          .collection(AppStrings.projectsCollection)
          .doc(project.id)
          .update(
            project.toJson(),
          );
      return const Right(
        AppStrings.projectUpdatedSuccessfully,
      );
    } on FirebaseException catch (e) {
      return Left(
        '${AppStrings.updateProjectFailed} ${e.code}',
      );
    } catch (e) {
      return Left(
        '${AppStrings.updateProjectFailed} $e',
      );
    }
  }

  Future<Either<String, String>> deleteProject({
    required Project project,
  }) async {
    try {
      await storage
          .collection(AppStrings.projectsCollection)
          .doc(project.id)
          .delete();
      return const Right(
        AppStrings.projectDeletedSuccessfully,
      );
    } on FirebaseException catch (e) {
      return Left(
        '${AppStrings.deleteProjectFailed} ${e.code}',
      );
    } catch (e) {
      return Left(
        '${AppStrings.deleteProjectFailed} $e',
      );
    }
  }

  Future<Either<String, List<Project>>> getAllProjects() async {
    try {
      List<Project> projects = [];
      QuerySnapshot<Map<String, dynamic>> response = await storage
          .collection(AppStrings.projectsCollection)
          .where(
            'collaborators',
            arrayContains: auth.currentUser!.email,
          )
          .orderBy(
            'createdAt',
            descending: true,
          )
          .get();

      if (response.docs.isNotEmpty) {
        for (var project in response.docs) {
          projects.add(
            Project.fromJson(
              project.data(),
            ),
          );
        }
      }
      return Right(
        projects,
      );
    } on FirebaseException catch (e) {
      return Left(
        '${AppStrings.getAllProjectsFailed} ${e.code}',
      );
    } catch (e) {
      return Left(
        '${AppStrings.getAllProjectsFailed} $e',
      );
    }
  }
}
