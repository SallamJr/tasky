import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_app_bar.dart';

import '../../../../core/utils/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        hasLogo: false,
        title: 'About Tasky',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.defaultPadding,
          vertical: Constants.defaultPadding * 2,
        ),
        child: Column(
          children: [
            Text(
              'Tasky App manage your projects and tasks for you.',
            ),
          ],
        ),
      ),
    );
  }
}
