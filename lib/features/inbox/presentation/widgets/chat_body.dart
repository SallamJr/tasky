import 'package:flutter/material.dart';

import '../../../auth/data/models/user_model.dart';
import 'custom_message_input.dart';
import 'custom_message_list.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: CustomMessageList(),
        ),
        CustomMessageInput(),
      ],
    );
  }
}
