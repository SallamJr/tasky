import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../auth/data/models/user_model.dart';
import '../controllers/inbox_cubit/inbox_cubit.dart';
import 'custom_user_inbox_item.dart';

class InboxBody extends StatelessWidget {
  const InboxBody({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: BlocProvider.of<InboxCubit>(context).inboxStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Error',
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CustomLoading(
              shadow: false,
            ),
          );
        }
        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.defaultPadding,
            vertical: Constants.defaultPadding * 2,
          ),
          children: snapshot.data!.docs.map<Widget>(
            (DocumentSnapshot doc) {
              Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
              UserModel userDoc = UserModel.fromJson(data);
              if (BlocProvider.of<InboxCubit>(context)
                      .auth
                      .currentUser!
                      .email !=
                  userDoc.email) {
                return CustomUserInboxItem(
                  userDoc: userDoc,
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ).toList(),
        );
      },
    );
  }
}
