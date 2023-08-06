import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../data/repositories/locale_repository.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final LocaleRepository localeRepository;

  LocaleCubit({
    required this.localeRepository,
  }) : super(
          const ChangeLocaleState(
            locale: Locale(
              AppStrings.englishCode,
            ),
          ),
        );

  String currentLanguageCode = AppStrings.englishCode;

  Future<void> getSavedLanguage() async {
    final response = await localeRepository.getSavedLanguage();
    response.fold((failure) => AppStrings.cacheFailure.debugLog(), (value) {
      currentLanguageCode = value!;
      emit(
        ChangeLocaleState(
          locale: Locale(currentLanguageCode),
        ),
      );
    });
  }

  Future<void> _changeLanguage(String languageCode) async {
    final response =
        await localeRepository.changeLanguage(languageCode: languageCode);
    response.fold((failure) => AppStrings.cacheFailure.debugLog(), (value) {
      currentLanguageCode = languageCode;
      emit(
        ChangeLocaleState(
          locale: Locale(currentLanguageCode),
        ),
      );
    });
  }

  void toEnglish() => _changeLanguage(AppStrings.englishCode);

  void toArabic() => _changeLanguage(AppStrings.arabicCode);
}
