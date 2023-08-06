import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../controllers/auth_repo_cubit/auth_repo_cubit.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AuthRepoCubit>().forgotPasswordFormKey,
      child: ListView(
        padding: const EdgeInsets.all(Constants.defaultPadding),
        children: [
          const Text(AppStrings.forgotPassword),
          (Constants.defaultPadding / 2).ySizedBox,
          Text(
            AppStrings.provideYourEmailToSendYouPasswordRestCode,
            style: AppTextStyles.hintTextStyle,
          ),
          Constants.defaultPadding.ySizedBox,
          CustomTextFormField(
            controller: BlocProvider.of<AuthRepoCubit>(context)
                .forgotPasswordEmailController,
            hint: AppStrings.email,
            keyboardType: TextInputType.emailAddress,
            validator: (email) => Helper.emailValidator(email: email),
          ),
          Constants.defaultPadding.ySizedBox,
          CustomElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthRepoCubit>(context).sendPasswordResetEmail();
            },
            text: AppStrings.send,
          ),
        ],
      ),
    );
  }
}
