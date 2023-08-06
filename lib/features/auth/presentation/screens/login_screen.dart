import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../home/presentation/controllers/nav_bar_cubit/nav_bar_cubit.dart';
import '../../../home/presentation/controllers/profile_cubit/profile_cubit.dart';
import '../../../home/presentation/controllers/projects_cubit/projects_cubit.dart';
import '../controllers/auth_bloc/auth_bloc.dart';
import '../controllers/auth_repo_cubit/auth_repo_cubit.dart';
import '../widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthRepoCubit, AuthRepoState>(
      listener: (context, state) {
        if (state.status == ControllerStateStatus.success) {
          Helper.showCustomSnackBar(
            context: context,
            message: state.message,
            snackBarStatus: SnackBarStatus.success,
          );
          BlocProvider.of<AuthBloc>(context).add(
            AuthenticatedRequestedEvent(),
          );
          BlocProvider.of<AuthRepoCubit>(context).resetCubit();
          BlocProvider.of<NavBarCubit>(context).resetCubit();
          BlocProvider.of<ProfileCubit>(context).getUserData();
          BlocProvider.of<ProjectsCubit>(context).getAllProjects();
          Navigator.pushReplacementNamed(
            context,
            Routes.navBarRoute,
          );
        } else if (state.status == ControllerStateStatus.error) {
          Helper.showCustomSnackBar(
            context: context,
            message: state.message,
            snackBarStatus: SnackBarStatus.error,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: AppStrings.login,
          ),
          body: Stack(
            children: [
              AbsorbPointer(
                absorbing: state.status == ControllerStateStatus.loading
                    ? true
                    : false,
                child: const LoginBody(),
              ),
              state.status == ControllerStateStatus.loading
                  ? const CustomLoading()
                  : const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
