import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bg_container_view.dart';
import '../../../../core/widgets/custom_list_tile_view.dart';

class DevelopersScreen extends StatelessWidget {
  const DevelopersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        hasLogo: false,
        title: 'About Developers',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.defaultPadding,
          vertical: Constants.defaultPadding * 2,
        ),
        child: Column(
          children: [
            CustomBgContainerView(
              padding: EdgeInsets.zero,
              child: CustomListTileView(
                title: 'Ahmed Essam Sallam',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
