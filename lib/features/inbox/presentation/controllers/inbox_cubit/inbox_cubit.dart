import 'dart:developer' as dev;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../data/models/message_model.dart';

part 'inbox_state.dart';

class InboxCubit extends Cubit<InboxState> {
  InboxCubit({
    required this.audioPlayer,
  }) : super(
          InboxState.initial(),
        );

  final AudioPlayer audioPlayer;

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  final Tween<Offset> offset = Tween(
    begin: const Offset(-2, 0),
    end: const Offset(0, 0),
  );

  Stream<QuerySnapshot<Map<String, dynamic>>> inboxStream = FirebaseFirestore
      .instance
      .collection(AppStrings.usersCollection)
      .snapshots();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseAuth get auth => _auth;

  FirebaseFirestore get firestore => _firestore;

  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  void resetController() => controller.clear();

  void setSelectedUser({
    required UserModel user,
  }) =>
      emit(
        state.copyWith(
          user: user,
        ),
      );

  String getChatRoomId({
    required String currentUserId,
    required String otherUserId,
  }) {
    List<String> ids = [currentUserId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return chatRoomId;
  }

  void scrollToTop() {
    scrollController.animateTo(
      scrollController.initialScrollOffset,
      duration: const Duration(
        seconds: 2,
      ),
      curve: Curves.linear,
    );
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.minScrollExtent + 400 &&
        !scrollController.position.outOfRange) {
      dev.log(
        'reach the top',
      );
      emit(
        state.copyWith(
          scrollPosition: MyScrollPosition.top,
        ),
      );
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      dev.log(
        'reach the bottom',
      );
      emit(
        state.copyWith(
          scrollPosition: MyScrollPosition.bottom,
        ),
      );
    }
  }

  void startScrollController() {
    scrollController.addListener(_scrollListener);
  }

  void startAnimation() {
    List<MessageModel> currentList = [];

    Stream<QuerySnapshot<Object?>> stream = getMessages();

    stream.listen(
      (newMessages) {
        final List<MessageModel> messageList = newMessages.docs
            .map(
              (message) => MessageModel.fromJson(
                message.data() as Map<String, dynamic>,
              ),
            )
            .toList();

        if (listKey.currentState != null &&
            listKey.currentState!.widget.initialItemCount <
                messageList.length) {
          List updateList =
              messageList.where((e) => !currentList.contains(e)).toList();

          for (var update in updateList) {
            final int updateIndex = messageList.indexOf(update);
            listKey.currentState!.insertItem(updateIndex);
          }
        }

        currentList = messageList;
      },
    );
  }

  Future<String> uploadImages({
    required String chatRoomId,
  }) async {
    dev.log('uploading image...');
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      // imageQuality: 40,
      // maxHeight: 800,
      // maxWidth: 800,
    );
    String url = '';
    if (image != null) {
      dev.log(image.name);
      final FirebaseStorage storage = FirebaseStorage.instance;
      final Reference storageRef = storage.ref();
      final Reference ref =
          storageRef.child('images/$chatRoomId/${image.name}');
      var file = File(image.path);
      final TaskSnapshot data = await ref.putFile(file);
      url = await ref.getDownloadURL();
      dev.log(
        'name: ${data.ref.name} + url: $url',
      );
    }
    return url;
  }

  Future<void> sendMessage({
    MessageType messageType = MessageType.text,
  }) async {
    try {
      // await setSoundUrl();
      await setSoundAsset();
      String url = '';
      final String currentUserId = auth.currentUser!.uid;
      final String currentUserEmail = auth.currentUser!.email ?? '';
      final DateTime createdAt = DateTime.now();
      String chatRoomId = getChatRoomId(
        currentUserId: currentUserId,
        otherUserId: state.user.id,
      );

      if (messageType == MessageType.text && controller.text.isEmpty) {
        return;
      } else if (messageType == MessageType.image) {
        url = await uploadImages(chatRoomId: chatRoomId);
      }

      MessageModel message = MessageModel(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: state.user.id,
        createdAt: createdAt,
        message: messageType == MessageType.image ? url : controller.text,
        messageType: messageType,
      );

      await firestore
          .collection(AppStrings.chatRoomsCollection)
          .doc(chatRoomId)
          .collection(AppStrings.messagesCollection)
          .add(
            message.toJson(),
          )
          .onError(
            (error, stackTrace) => throw 'Error: $error',
          )
          .whenComplete(
        () {
          resetController();
          playSendSound();
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: '$e',
          status: ControllerStateStatus.error,
        ),
      );
    }
  }

  Stream<QuerySnapshot<Object?>> getMessages() {
    final String currentUserId = auth.currentUser!.uid;

    String chatRoomId = getChatRoomId(
      currentUserId: currentUserId,
      otherUserId: state.user.id,
    );

    return firestore
        .collection(AppStrings.chatRoomsCollection)
        .doc(chatRoomId)
        .collection(AppStrings.messagesCollection)
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots();
  }

  Future<void> playSendSound() async {
    try {
      await audioPlayer.play();
    } catch (e) {
      dev.log('$e');
    }
  }

  Future<void> setSoundUrl() async {
    try {
      await audioPlayer.setUrl(
        AppStrings.sendMessageAudio,
      );
    } catch (e) {
      dev.log('$e');
    }
  }

  Future<void> setSoundAsset() async {
    try {
      await audioPlayer.setAsset(
        'assets/audio/message _sent.mp3',
      );
    } catch (e) {
      dev.log('$e');
    }
  }
}
