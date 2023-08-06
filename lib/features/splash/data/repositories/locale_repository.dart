import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_strings.dart';

class LocaleRepository {
  LocaleRepository({
    required this.pref,
  });

  SharedPreferences pref;

  Future<bool> saveSelectedLanguage({required String languageCode}) async =>
      await pref.setString(AppStrings.locale, languageCode);

  Future<String?> getLanguage() async => pref.containsKey(AppStrings.locale)
      ? pref.getString(AppStrings.locale)
      : AppStrings.englishCode;

  Future<Either<Failure, bool>> changeLanguage(
      {required String languageCode}) async {
    try {
      final languageIsChanged =
          await saveSelectedLanguage(languageCode: languageCode);
      return Right(languageIsChanged);
    } on CacheException {
      return Left(
        CacheFailure(),
      );
    }
  }

  Future<Either<Failure, String?>> getSavedLanguage() async {
    try {
      final languageCode = await getLanguage();
      return Right(languageCode);
    } on CacheException {
      return Left(
        CacheFailure(),
      );
    }
  }
}
