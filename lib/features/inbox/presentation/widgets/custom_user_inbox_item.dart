import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_cached_network_image.dart';
import '../../../auth/data/models/user_model.dart';
import '../controllers/inbox_cubit/inbox_cubit.dart';

class CustomUserInboxItem extends StatelessWidget {
  const CustomUserInboxItem({
    super.key,
    required this.userDoc,
  });

  final UserModel userDoc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Constants.defaultPadding / 2,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Constants.defaultPadding * 2,
          vertical: Constants.defaultPadding / 2.5,
        ),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            Constants.borderRadius,
          ),
        ),
        tileColor: AppColors.secondary,
        leading: userDoc.profileImage.isNotEmpty
            ? CustomCachedNetworkImage(
                width: 50,
                height: 50,
                borderRadius: 50,
                url: userDoc.profileImage,
              )
            : null,
        title: Text(
          userDoc.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          BlocProvider.of<InboxCubit>(context).setSelectedUser(
            user: userDoc,
          );
          // startAnimation
          BlocProvider.of<InboxCubit>(context).startAnimation();
          BlocProvider.of<InboxCubit>(context).startScrollController();
          context.push(
            routeName: Routes.chatRoute,
          );
        },
      ),
    );
  }
}
