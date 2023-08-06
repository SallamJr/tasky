import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_strings.dart';

class OnboardingRepository {
  OnboardingRepository({
    required this.pref,
  });

  SharedPreferences pref;

  Future<bool> saveOnboardingStatus({required bool viewed}) async =>
      await pref.setBool(AppStrings.onboarding, viewed);

  Future<bool?> getOnboardingStatus() async =>
      pref.containsKey(AppStrings.onboarding)
          ? pref.getBool(AppStrings.onboarding)
          : false;

  Future<Either<Failure, bool>> changeOnboardingStatus(
      {required bool viewed}) async {
    try {
      final onboardingStatusIsChanged = await saveOnboardingStatus(
        viewed: viewed,
      );
      return Right(onboardingStatusIsChanged);
    } on CacheException {
      return Left(
        CacheFailure(),
      );
    }
  }

  Future<Either<Failure, bool?>> getSavedOnboardingStatus() async {
    try {
      final onboardingStatus = await getOnboardingStatus();
      return Right(onboardingStatus);
    } on CacheException {
      return Left(
        CacheFailure(),
      );
    }
  }
}
