import 'package:flutter/material.dart';

import '../utils/app_strings.dart';
import '../utils/app_text_styles.dart';

class EmptyListView extends StatelessWidget {
  const EmptyListView({
    super.key,
    required this.text,
    this.shrinkWrap = false,
    this.padding,
  });

  final String text;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding,
      shrinkWrap: shrinkWrap,
      children: [
        Center(
          child: Text(
            '$text ${AppStrings.listIsEmpty}',
            style: AppTextStyles.hintTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
