import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/helper.dart';
import '../../../auth/presentation/controllers/auth_bloc/auth_bloc.dart';
import '../../../onboarding/presentation/controllers/cubit/onboarding_cubit.dart';
import '../controllers/splash_cubit/splash_cubit.dart';
import '../widgets/splash_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> getOnBoardingStatus() async {
      await BlocProvider.of<OnboardingCubit>(context).getOnboardingStatus();
    }

    checkNextRoute() {
      bool onboardingStatus =
          BlocProvider.of<OnboardingCubit>(context).currentOnboardingStatus;
      if (onboardingStatus) {
        final String status = BlocProvider.of<AuthBloc>(context).state.status;
        final bool authenticated = Helper.checkUserStatus(status);
        if (authenticated) {
          Navigator.pushReplacementNamed(
            context,
            Routes.navBarRoute,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            Routes.loginRoute,
          );
        }
      } else {
        Navigator.pushReplacementNamed(
          context,
          Routes.onboadringRoute,
        );
      }
    }

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) async {
        if (state is SplashTransition) {
          // BlocProvider.of<PushNotificationCubit>(context).requestPermission();
          await getOnBoardingStatus();
          checkNextRoute();
        }
      },
      child: const Scaffold(
        body: SplashBody(),
      ),
    );
  }
}
