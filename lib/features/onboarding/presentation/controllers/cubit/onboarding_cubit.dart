import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/extensions/extensions.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../data/repositories/onboarding_repository.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required this.onboardingRepository,
  }) : super(
          const ChangeOnboardingState(
            status: false,
          ),
        );

  final OnboardingRepository onboardingRepository;

  bool currentOnboardingStatus = false;

  Future<void> getOnboardingStatus() async {
    final response = await onboardingRepository.getSavedOnboardingStatus();
    response.fold((failure) => AppStrings.cacheFailure.debugLog(), (value) {
      '$currentOnboardingStatus'.debugLog();
      currentOnboardingStatus = value!;
      emit(
        ChangeOnboardingState(
          status: currentOnboardingStatus,
        ),
      );
    });
  }

  Future<void> _changeOnboardingStatus(bool status) async {
    final response =
        await onboardingRepository.changeOnboardingStatus(viewed: status);
    response.fold((failure) => AppStrings.cacheFailure.debugLog(), (value) {
      currentOnboardingStatus = status;
      emit(
        ChangeOnboardingState(
          status: currentOnboardingStatus,
        ),
      );
    });
  }

  void toViewed() => _changeOnboardingStatus(true);

  void toNotViewed() => _changeOnboardingStatus(false);
}
