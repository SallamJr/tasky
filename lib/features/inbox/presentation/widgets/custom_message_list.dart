import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../data/models/message_model.dart';
import '../controllers/inbox_cubit/inbox_cubit.dart';
import 'custom_message_item.dart';

class CustomMessageList extends StatelessWidget {
  const CustomMessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: BlocProvider.of<InboxCubit>(context).getMessages(),
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
        return snapshot.data!.docs.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'No Messages yet!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Start Messaging now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              )
            : AnimatedList(
                key: BlocProvider.of<InboxCubit>(context).listKey,
                controller:
                    BlocProvider.of<InboxCubit>(context).scrollController,
                reverse: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.defaultPadding,
                  vertical: Constants.defaultPadding * 2,
                ),
                initialItemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index, animation) {
                  QueryDocumentSnapshot doc = snapshot.data!.docs[index];
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  MessageModel message = MessageModel.fromJson(data);
                  bool isSender = message.senderId ==
                      BlocProvider.of<InboxCubit>(context)
                          .auth
                          .currentUser!
                          .uid;
                  return SlideTransition(
                    position: animation.drive(
                      BlocProvider.of<InboxCubit>(context).offset,
                    ),
                    child: CustomMessageItem(
                      message: message,
                      isSender: isSender,
                    ),
                  );
                },
              );
      },
    );
  }
}
