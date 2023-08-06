import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_clickable_detector.dart';
import '../../../../core/widgets/custom_svg_asset_picture.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../controllers/inbox_cubit/inbox_cubit.dart';

class CustomMessageInput extends StatelessWidget {
  const CustomMessageInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Constants.defaultPadding * 2,
        left: Constants.defaultPadding,
        right: Constants.defaultPadding,
      ),
      child: Row(
        children: [
          CustomClickableDetector(
            onPressed: () => BlocProvider.of<InboxCubit>(context).sendMessage(
              messageType: MessageType.image,
            ),
            borderRadius: Constants.borderRadius,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.defaultPadding / 2,
                vertical: Constants.defaultPadding / 2,
              ),
              child: CustomSvgAssetPicture(
                width: Constants.defaultPadding * 1.3,
                height: Constants.defaultPadding * 1.3,
                assetName: AssetsManager.galleryIconPath,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(
            width: Constants.defaultPadding / 2,
          ),
          Expanded(
            child: CustomTextFormField(
              controller: BlocProvider.of<InboxCubit>(context).controller,
              hint: 'send a message...',
              textInputAction: TextInputAction.send,
              onFieldSubmitted: (_) =>
                  BlocProvider.of<InboxCubit>(context).sendMessage(),
            ),
          ),
          const SizedBox(
            width: Constants.defaultPadding / 2,
          ),
          CustomClickableDetector(
            onPressed: () => BlocProvider.of<InboxCubit>(context).sendMessage(),
            borderRadius: Constants.borderRadius,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.defaultPadding / 2,
                vertical: Constants.defaultPadding / 2,
              ),
              child: CustomSvgAssetPicture(
                width: Constants.defaultPadding * 1.3,
                height: Constants.defaultPadding * 1.3,
                assetName: AssetsManager.sendIconPath,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
