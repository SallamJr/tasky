import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'core/api/api_consumer.dart';
import 'core/network/network_info.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'features/auth/presentation/controllers/auth_repo_cubit/auth_repo_cubit.dart';
import 'features/home/data/repositories/projects_repository.dart';
import 'features/home/data/repositories/tasks_repository.dart';
import 'features/home/presentation/controllers/nav_bar_cubit/nav_bar_cubit.dart';
import 'features/home/presentation/controllers/profile_cubit/profile_cubit.dart';
import 'features/home/presentation/controllers/projects_cubit/projects_cubit.dart';
import 'features/home/presentation/controllers/tasks_cubit/tasks_cubit.dart';
import 'features/inbox/presentation/controllers/inbox_cubit/inbox_cubit.dart';
import 'features/onboarding/data/repositories/onboarding_repository.dart';
import 'features/onboarding/presentation/controllers/cubit/onboarding_cubit.dart';
import 'features/splash/data/repositories/locale_repository.dart';
import 'features/splash/presentation/controllers/locale_cubit/locale_cubit.dart';
import 'features/splash/presentation/controllers/splash_cubit/splash_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> setup() async {
  // Blocs

  serviceLocator.registerFactory(
    () => SplashCubit(),
  );

  serviceLocator.registerFactory(
    () => LocaleCubit(
      localeRepository: serviceLocator(),
    ),
  );

  // serviceLocator.registerFactory<PushNotificationCubit>(
  //   () => PushNotificationCubit(),
  // );

  serviceLocator.registerFactory<AuthBloc>(
    () => AuthBloc(),
  );

  serviceLocator.registerFactory<TasksCubit>(
    () => TasksCubit(
      tasksRepository: serviceLocator(),
      uuid: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepoCubit>(
    () => AuthRepoCubit(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<ProjectsCubit>(
    () => ProjectsCubit(
      projectsRepository: serviceLocator(),
      uuid: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(
      onboardingRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<NavBarCubit>(
    () => NavBarCubit(),
  );

  serviceLocator.registerFactory<InboxCubit>(
    () => InboxCubit(
      audioPlayer: serviceLocator(),
    ),
  );

  // Repositories

  serviceLocator.registerLazySingleton<LocaleRepository>(
    () => LocaleRepository(
      pref: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepository(),
  );

  serviceLocator.registerLazySingleton<TasksRepository>(
    () => TasksRepository(),
  );

  serviceLocator.registerLazySingleton<ProjectsRepository>(
    () => ProjectsRepository(),
  );

  serviceLocator.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepository(
      pref: serviceLocator(),
    ),
  );

  //Network

  serviceLocator.registerLazySingleton<BaseNetworkInfo>(
    () => NetworkInfo(
      connectionChecker: serviceLocator(),
    ),
  );

  // Api Consumer

  serviceLocator.registerLazySingleton<BaseApiConsumer>(
    () => ApiConsumer(),
  );

  // Shared Preferences

  final sharedPreferences = await SharedPreferences.getInstance();

  serviceLocator.registerLazySingleton(
    () => sharedPreferences,
  );

  // uuid

  serviceLocator.registerLazySingleton(
    () => const Uuid(),
  );

  // audio player

  serviceLocator.registerLazySingleton(
    () => AudioPlayer(),
  );

  // Internet Connection Checker

  serviceLocator.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
}
