import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/utils/app_strings.dart';
import '../models/task.dart';

class TasksRepository {
  TasksRepository();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore storage = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> collaboratorsStream({
    required String projectId,
  }) =>
      storage
          .collection(AppStrings.projectsCollection)
          .doc(projectId)
          .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> tasksStream({
    required String projectId,
  }) =>
      storage
          .collection(AppStrings.tasksCollection)
          .where(
            'projectId',
            isEqualTo: projectId,
          )
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots();

  Future<Either<String, String>> createTask({
    required MyTask task,
  }) async {
    try {
      await storage.collection(AppStrings.tasksCollection).doc(task.id).set(
            task.toJson(),
          );
      return const Right(
        AppStrings.taskCreatedSuccessfully,
      );
    } on FirebaseException catch (e) {
      return Left(
        '${AppStrings.createTaskFailed} ${e.code}',
      );
    } catch (e) {
      return Left(
        '${AppStrings.createTaskFailed} $e',
      );
    }
  }

  Future<Either<String, String>> updateTask({
    required MyTask task,
  }) async {
    try {
      await storage.collection(AppStrings.tasksCollection).doc(task.id).update(
            task.toJson(),
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

  Future<Either<String, String>> deleteTask({
    required MyTask task,
  }) async {
    try {
      await storage
          .collection(AppStrings.tasksCollection)
          .doc(task.id)
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

  Future<Either<String, List<MyTask>>> getAllTasks({
    required String projectId,
  }) async {
    try {
      List<MyTask> tasks = [];
      QuerySnapshot<Map<String, dynamic>> response = await storage
          .collection(AppStrings.tasksCollection)
          .where(
            'projectId',
            isEqualTo: projectId,
          )
          .orderBy(
            'createdAt',
            descending: true,
          )
          .get();

      if (response.docs.isNotEmpty) {
        for (var task in response.docs) {
          tasks.add(
            MyTask.fromJson(
              task.data(),
            ),
          );
        }
      }
      return Right(
        tasks,
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
