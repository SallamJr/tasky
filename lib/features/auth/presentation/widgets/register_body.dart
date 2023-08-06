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

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AuthRepoCubit>().registerFormKey,
      child: ListView(
        padding: const EdgeInsets.all(Constants.defaultPadding),
        children: [
          const Text(AppStrings.register),
          (Constants.defaultPadding / 2).ySizedBox,
          Text(
            AppStrings.createNewAccount,
            style: AppTextStyles.hintTextStyle,
          ),
          Constants.defaultPadding.ySizedBox,
          CustomTextFormField(
            controller:
                BlocProvider.of<AuthRepoCubit>(context).registerNameController,
            hint: AppStrings.name,
          ),
          (Constants.defaultPadding / 2).ySizedBox,
          CustomTextFormField(
            controller:
                BlocProvider.of<AuthRepoCubit>(context).registerEmailController,
            hint: AppStrings.email,
            keyboardType: TextInputType.emailAddress,
            validator: (email) => Helper.emailValidator(
              email: email,
            ),
          ),
          (Constants.defaultPadding / 2).ySizedBox,
          CustomTextFormField(
            controller: BlocProvider.of<AuthRepoCubit>(context)
                .registerPasswordController,
            hint: AppStrings.password,
            isPassword: true,
            maxLines: 1,
            validator: (password) => Helper.passwordValidator(
              password: password,
            ),
          ),
          Constants.defaultPadding.ySizedBox,
          CustomElevatedButton(
            onPressed: () => BlocProvider.of<AuthRepoCubit>(context).register(),
            text: AppStrings.register,
          ),
        ],
      ),
    );
  }
}
