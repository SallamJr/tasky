import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class CustomScrollableBottomSheetView extends StatelessWidget {
  const CustomScrollableBottomSheetView({
    super.key,
    this.formKey,
    required this.title,
    required this.controller,
    required this.hintText,
    required this.buttonText,
    required this.onPressed,
    this.validator,
    this.keyboardType,
  });

  final GlobalKey<FormState>? formKey;
  final String title;
  final TextEditingController controller;
  final String hintText;
  final String buttonText;
  final Function()? onPressed;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Constants.defaultPadding,
          vertical: Constants.defaultPadding * 2,
        ),
        child: SizedBox(
          height: context.height * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.primary,
                  ),
                ),
              ),
              Constants.defaultPadding.ySizedBox,
              CustomTextFormField(
                controller: controller,
                keyboardType: keyboardType,
                hint: hintText,
                validator: validator,
              ),
              Constants.defaultPadding.ySizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextButton(
                    text: buttonText,
                    underline: false,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    onPressed: onPressed,
                  ),
                  CustomTextButton(
                    text: 'Cancel',
                    underline: false,
                    fontSize: 16,
                    color: AppColors.red,
                    fontWeight: FontWeight.bold,
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
