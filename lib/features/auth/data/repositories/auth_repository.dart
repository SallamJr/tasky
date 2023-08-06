import 'dart:developer' as dev;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/core/extensions/extensions.dart';

import '../../../../core/utils/app_strings.dart';
import '../models/user_model.dart';

class AuthRepository {
  AuthRepository();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore storage = FirebaseFirestore.instance;
  FirebaseStorage mediaStorage = FirebaseStorage.instance;

  String get uid => auth.currentUser!.uid;

  String get email => auth.currentUser!.email!;

  Stream<DocumentSnapshot<Map<String, dynamic>>> get userDataStream => storage
      .collection(AppStrings.usersCollection)
      .doc(auth.currentUser!.uid)
      .snapshots();

  Future<Either<String, String>> uploadUserImage({
    required XFile image,
  }) async {
    try {
      dev.log('uploading image...');
      dev.log(image.name);
      final Reference storageRef = mediaStorage.ref();
      final Reference ref =
          storageRef.child('profile/${auth.currentUser!.uid}/${image.name}');
      var file = File(image.path);
      final TaskSnapshot data = await ref.putFile(file);
      String url = await ref.getDownloadURL();
      auth.currentUser!.updatePhotoURL(url);
      await storage
          .collection(AppStrings.usersCollection)
          .doc(auth.currentUser!.uid)
          .update({
        'profileImage': url,
      });
      dev.log(
        'name: ${data.ref.name} + url: $url',
      );
      return Right(
        url,
      );
    } on FirebaseAuthException catch (e) {
      return Left(
        'Upload User Image Failed ${e.code}',
      );
    } catch (e) {
      return Left(
        'Upload User Image Failed $e',
      );
    }
  }

  Future<Either<String, UserModel>> getUserData() async {
    try {
      final response = await storage
          .collection(AppStrings.usersCollection)
          .doc(auth.currentUser!.uid)
          .get();

      final data = response.data()!;

      return Right(
        UserModel.fromJson(
          data,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return Left(
        '${AppStrings.userDataRetrievedFailed} ${e.code}',
      );
    } catch (e) {
      return Left(
        '${AppStrings.userDataRetrievedFailed} $e',
      );
    }
  }

  Future<Either<String, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      final String? fcmToken = await messaging.getToken();
      '##### FCM TOKEN ##### $fcmToken'.debugLog();
      final UserCredential credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        if (auth.currentUser != null) {
          auth.currentUser!.updateEmail(email);
        }
        await storage
            .collection(AppStrings.usersCollection)
            .doc(credential.user!.uid)
            .update({
          'fcmToken': fcmToken,
        });
        return const Right(
          AppStrings.loginSuccessfully,
        );
      } else {
        return const Left(
          AppStrings.loginFailed,
        );
      }
    } on FirebaseAuthException catch (e) {
      return Left(
        '${AppStrings.loginFailed} ${e.code}',
      );
    } catch (e) {
      return Left(
        '${AppStrings.loginFailed} $e',
      );
    }
  }

  Future<Either<String, String>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      final String? fcmToken = await messaging.getToken();
      '##### FCM TOKEN ##### $fcmToken'.debugLog();
      final UserCredential credential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (auth.currentUser != null) {
        auth.currentUser!.updateEmail(email);
      }
      final UserModel user = UserModel(
        id: credential.user!.uid,
        email: email,
        fcmToken: fcmToken!,
        name: name,
        password: password,
        profileImage: '',
      );
      if (credential.user != null) {
        await storage
            .collection(AppStrings.usersCollection)
            .doc(credential.user!.uid)
            .set(
              user.toJson(),
            );
        return const Right(
          AppStrings.accountCreatedSuccessfully,
        );
      } else {
        return const Left(
          AppStrings.accountCreationFailed,
        );
      }
    } on FirebaseAuthException catch (e) {
      return Left(
        '${AppStrings.accountCreationFailed} ${e.code}',
      );
    } catch (e) {
      return Left(
        '${AppStrings.accountCreationFailed} $e',
      );
    }
  }

  Future<Either<String, String>> logout() async {
    try {
      await auth.signOut();
      return const Right(
        AppStrings.logoutSuccessfully,
      );
    } on FirebaseAuthException catch (e) {
      return Left(
        '${AppStrings.logoutFailed} ${e.code}',
      );
    } catch (e) {
      return Left(
        '${AppStrings.logoutFailed} $e',
      );
    }
  }

  Future<Either<String, String>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
      return const Right(
        AppStrings.sendPasswordResetEmailSuccessfully,
      );
    } on FirebaseAuthException catch (e) {
      return Left(
        '${AppStrings.sendPasswordResetEmailFailed} ${e.code}',
      );
    } catch (e) {
      return Left(
        '${AppStrings.sendPasswordResetEmailFailed} $e',
      );
    }
  }
}
