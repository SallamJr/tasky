import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/widgets/custom_loading.dart';
import 'package:tasky/features/auth/presentation/controllers/auth_bloc/auth_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../auth/presentation/controllers/auth_repo_cubit/auth_repo_cubit.dart';
import '../controllers/profile_cubit/profile_cubit.dart';
import '../widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthRepoCubit, AuthRepoState>(
      listener: (context, state) {
        if (state.status == ControllerStateStatus.success) {
          Helper.showCustomSnackBar(
            context: context,
            message: state.message,
            snackBarStatus: SnackBarStatus.success,
          );
          BlocProvider.of<AuthBloc>(context).add(
            SignOutRequestedEvent(),
          );
          context.pop();
          context.pushReplacement(
            routeName: Routes.loginRoute,
          );
        } else if (state.status == ControllerStateStatus.error) {
          Helper.showCustomSnackBar(
            context: context,
            message: state.message,
            snackBarStatus: SnackBarStatus.error,
          );
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          hasLogo: false,
          title: AppStrings.profile,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Stack(
              children: [
                const ProfileBody(),
                state.status == ControllerStateStatus.updating
                    ? const Align(
                        alignment: Alignment.center,
                        child: CustomLoading(),
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }
}
