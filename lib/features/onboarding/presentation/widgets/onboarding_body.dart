import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/widgets/custom_elevated_button.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/helper.dart';
import '../../../auth/presentation/controllers/auth_bloc/auth_bloc.dart';
import '../controllers/cubit/onboarding_cubit.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.defaultPadding,
        vertical: Constants.defaultPadding * 2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Welcome To Tasky App',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Tasky App manage your projects and tasks for you.',
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              Expanded(
                child: CustomElevatedButton(
                  text: 'Skip',
                  backgroundColor: AppColors.secondary,
                  onPressed: () {
                    BlocProvider.of<OnboardingCubit>(context).toViewed();
                    final String status =
                        BlocProvider.of<AuthBloc>(context).state.status;
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
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
