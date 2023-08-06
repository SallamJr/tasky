import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_app_bar.dart';

import '../widgets/onboarding_body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: OnboardingBody(),
    );
  }
}
