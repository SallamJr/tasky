import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomStepperView extends StatelessWidget {
  const CustomStepperView({
    super.key,
    required this.steps,
  });

  final List<Widget> steps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.defaultPadding / 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: steps,
      ),
    );
  }
}
