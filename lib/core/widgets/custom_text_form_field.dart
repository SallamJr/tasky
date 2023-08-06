import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/extensions/extensions.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_field_border_styles.dart';
import '../utils/app_text_styles.dart';
import '../utils/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    this.title,
    this.suffixIconPath,
    this.keyboardType,
    this.isPassword = false,
    this.readOnly = false,
    this.onPressed,
    this.prefixIconPath,
    this.validator,
    this.onChanged,
    this.minLines,
    this.maxLines,
    this.autofocus = false,
    this.suffixIconOnPressed,
    this.enabledHintColorBlack = false,
    this.controller,
    this.textInputAction,
    this.onFieldSubmitted,
    this.size = false,
  });

  final String hint;
  final String? suffixIconPath;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool readOnly;
  final String? prefixIconPath;
  final Function()? onPressed;
  final String? title;
  final int? minLines;
  final int? maxLines;
  final bool autofocus;
  final Function()? suffixIconOnPressed;
  final bool enabledHintColorBlack;
  final bool size;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.only(
              left: Constants.defaultPadding / 2,
              bottom: Constants.defaultPadding / 2.5,
            ),
            child: Text(
              title!,
              style: AppTextStyles.hintTextStyle.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
          (Constants.defaultPadding / 4).ySizedBox,
        ],
        TextFormField(
          controller: controller,
          autocorrect: false,
          cursorColor: AppColors.primary,
          obscureText: isPassword,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          readOnly: readOnly,
          onTap: onPressed,
          maxLines: maxLines ?? 5,
          minLines: minLines ?? 1,
          autofocus: autofocus,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            filled: true,
            fillColor: AppColors.transparent,
            enabled: true,
            hintText: hint,
            hintStyle: AppTextStyles.hintTextStyle.copyWith(
              color:
                  enabledHintColorBlack ? AppColors.black : AppColors.lightGrey,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Constants.horizontalPadding,
              vertical: Constants.defaultPadding / 1.2,
            ),
            suffixIcon: (suffixIconPath != null)
                ? Padding(
                    padding: EdgeInsets.only(
                      top: size ? Constants.defaultPadding : 0,
                      bottom: size ? Constants.defaultPadding : 0,
                      right: Constants.defaultPadding,
                      left: Constants.defaultPadding / 4,
                    ),
                    child: InkWell(
                      onTap: suffixIconOnPressed,
                      child: SvgPicture.asset(
                        suffixIconPath!,
                      ),
                    ),
                  )
                : null,
            prefixIcon: (prefixIconPath != null)
                ? Padding(
                    padding: const EdgeInsets.only(
                      right: Constants.defaultPadding,
                      left: Constants.defaultPadding,
                    ),
                    child: SvgPicture.asset(
                      prefixIconPath!,
                      colorFilter: ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : null,
            border: AppTextFieldBorderStyles.border,
            enabledBorder: AppTextFieldBorderStyles.border,
            focusedBorder: AppTextFieldBorderStyles.border,
            disabledBorder: AppTextFieldBorderStyles.border,
            errorBorder: AppTextFieldBorderStyles.errorBorder,
            focusedErrorBorder: AppTextFieldBorderStyles.errorBorder,
          ),
        ),
      ],
    );
  }
}
