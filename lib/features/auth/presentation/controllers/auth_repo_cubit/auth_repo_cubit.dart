import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';

part 'auth_repo_state.dart';

class AuthRepoCubit extends Cubit<AuthRepoState> {
  AuthRepoCubit({
    required this.authRepository,
  }) : super(
          AuthRepoState.initial(),
        );

  final AuthRepository authRepository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController forgotPasswordEmailController =
      TextEditingController();

  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();

  void resetControllers() {
    emailController.clear();
    passwordController.clear();
    forgotPasswordEmailController.clear();
    registerNameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
  }

  void resetCubit() {
    resetControllers();
    emit(
      AuthRepoState.initial(),
    );
  }

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }
    emit(
      state.copyWith(status: ControllerStateStatus.loading),
    );

    Either<String, String> response = await authRepository.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
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

  Future<void> sendPasswordResetEmail() async {
    if (!forgotPasswordFormKey.currentState!.validate()) {
      return;
    }
    emit(
      state.copyWith(status: ControllerStateStatus.loading),
    );

    Either<String, String> response =
        await authRepository.sendPasswordResetEmail(
      email: forgotPasswordEmailController.text.trim(),
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

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) {
      return;
    }
    emit(
      state.copyWith(status: ControllerStateStatus.loading),
    );

    Either<String, String> response = await authRepository.register(
      name: registerNameController.text.trim(),
      email: registerEmailController.text.trim(),
      password: registerPasswordController.text.trim(),
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

  Future<void> logout() async {
    emit(
      state.copyWith(status: ControllerStateStatus.loading),
    );

    Either<String, String> response = await authRepository.logout();

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
}
