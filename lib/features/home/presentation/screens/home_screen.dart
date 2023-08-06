import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_svg_asset_picture.dart';
import '../controllers/projects_cubit/projects_cubit.dart';
import '../widgets/custom_scrollable_bottom_sheet_view.dart';
import '../widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        hasLogo: false,
        title: AppStrings.appName,
      ),
      body: const HomeBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.white,
        child: const CustomSvgAssetPicture(
          assetName: AssetsManager.plusIconPath,
        ),
        onPressed: () {
          context.read<ProjectsCubit>().resetController();
          Helper.showBottomSheet(
            context: context,
            isScrollControlled: true,
            child: CustomScrollableBottomSheetView(
              formKey: context.read<ProjectsCubit>().titleFormKey,
              title: 'Create Project',
              controller: context.read<ProjectsCubit>().titleController,
              hintText: 'Enter Project Title',
              buttonText: 'Create',
              validator: (value) => Helper.textValidator(
                value: value,
              ),
              onPressed: () {
                context.read<ProjectsCubit>().createProject();
                context.pop();
              },
            ),
          );
        },
      ),
    );
  }
}
