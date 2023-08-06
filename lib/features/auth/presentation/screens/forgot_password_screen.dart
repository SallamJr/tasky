import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../controllers/auth_repo_cubit/auth_repo_cubit.dart';
import '../widgets/forgot_password_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
          Navigator.pop(
            context,
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
            title: AppStrings.forgotPassword,
          ),
          body: Stack(
            children: [
              AbsorbPointer(
                absorbing: state.status == ControllerStateStatus.loading
                    ? true
                    : false,
                child: const ForgotPasswordBody(),
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
