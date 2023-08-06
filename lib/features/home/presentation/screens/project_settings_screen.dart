import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/project_settings_body.dart';

class ProjectSettingsScreen extends StatelessWidget {
  const ProjectSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
        hasLogo: false,
      ),
      body: ProjectSettingsBody(),
    );
  }
}
