import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../controllers/auth_repo_cubit/auth_repo_cubit.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AuthRepoCubit>().loginFormKey,
      child: ListView(
        padding: const EdgeInsets.all(Constants.defaultPadding),
        children: [
          const Text(AppStrings.welcomeBack),
          (Constants.defaultPadding / 2).ySizedBox,
          Text(
            AppStrings.loginToYourAccount,
            style: AppTextStyles.hintTextStyle,
          ),
          Constants.defaultPadding.ySizedBox,
          CustomTextFormField(
            controller: BlocProvider.of<AuthRepoCubit>(context).emailController,
            hint: AppStrings.email,
            validator: (email) => Helper.emailValidator(email: email),
            keyboardType: TextInputType.emailAddress,
          ),
          (Constants.defaultPadding / 2).ySizedBox,
          CustomTextFormField(
            controller:
                BlocProvider.of<AuthRepoCubit>(context).passwordController,
            hint: AppStrings.password,
            isPassword: true,
            maxLines: 1,
            validator: (password) => Helper.passwordValidator(
              password: password,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextButton(
                text: '${AppStrings.forgotPassword}?',
                onPressed: () {
                  BlocProvider.of<AuthRepoCubit>(context).resetControllers();
                  Navigator.pushNamed(
                    context,
                    Routes.forgotPasswordRoute,
                  );
                },
              ),
            ],
          ),
          CustomElevatedButton(
            onPressed: () => BlocProvider.of<AuthRepoCubit>(context).login(),
            text: AppStrings.login,
          ),
          Constants.defaultPadding.ySizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.doNotHaveAccount,
                style: AppTextStyles.hintTextStyle,
              ),
              CustomTextButton(
                text: AppStrings.register,
                onPressed: () {
                  BlocProvider.of<AuthRepoCubit>(context).resetControllers();
                  Navigator.pushNamed(
                    context,
                    Routes.registerRoute,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
