import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../../auth/data/repositories/auth_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.authRepository,
  }) : super(
          ProfileState.initial(),
        );

  final AuthRepository authRepository;

  String get uid => authRepository.uid;

  String get email => authRepository.email;

  Stream<DocumentSnapshot<Map<String, dynamic>>> get userDataStream =>
      authRepository.userDataStream;

  Future<void> getUserData({
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

    Either<String, UserModel> response = await authRepository.getUserData();

    emit(
      response.fold(
        (failure) => state.copyWith(
          message: failure,
          status: ControllerStateStatus.error,
        ),
        (user) => state.copyWith(
          message: AppStrings.userDataRetrievedSuccessfully,
          user: user,
          status: ControllerStateStatus.success,
        ),
      ),
    );
  }

  Future<void> uploadUserImage({
    bool updating = false,
  }) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) {
      return;
    }

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

    Either<String, String> response = await authRepository.uploadUserImage(
      image: image,
    );

    emit(
      response.fold(
        (failure) => state.copyWith(
          message: failure,
          status: ControllerStateStatus.error,
        ),
        (url) => state.copyWith(
          message: 'User Profile image uploaded successfully. $url',
          user: state.user.copyWith(
            profileImage: url,
          ),
          status: ControllerStateStatus.success,
        ),
      ),
    );
  }
}
