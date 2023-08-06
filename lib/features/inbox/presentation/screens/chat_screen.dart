import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/extensions/extensions.dart';

import '../../../../core/utils/helper.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../controllers/inbox_cubit/inbox_cubit.dart';
import '../widgets/chat_body.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InboxCubit, InboxState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            hasLogo: false,
            title: state.user.name,
          ),
          body: ChatBody(
            user: state.user,
          ),
          floatingActionButton: state.scrollPosition == MyScrollPosition.top
              ? Padding(
                  padding: EdgeInsets.only(
                    bottom: context.height * 0.1,
                  ),
                  child: FloatingActionButton(
                    onPressed: () =>
                        BlocProvider.of<InboxCubit>(context).scrollToTop(),
                    child: const Icon(
                      Icons.arrow_downward,
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
