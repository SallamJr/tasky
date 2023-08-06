import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/constants.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel extends Equatable {
  const MessageModel({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.createdAt,
    required this.message,
    this.messageType = MessageType.text,
  });

  final String senderId;
  final String senderEmail;
  final String receiverId;
  final DateTime createdAt;
  final String message;
  final MessageType messageType;

  MessageModel copyWith({
    String? senderId,
    String? senderEmail,
    String? receiverId,
    DateTime? createdAt,
    String? message,
    MessageType? messageType,
  }) {
    return MessageModel(
      senderId: senderId ?? this.senderId,
      senderEmail: senderEmail ?? this.senderEmail,
      receiverId: receiverId ?? this.receiverId,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
      messageType: messageType ?? this.messageType,
    );
  }

  static MessageModel fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  @override
  String toString() {
    return 'MessageModel(senderId: $senderId, senderEmail: $senderEmail, receiverId: $receiverId, createdAt: $createdAt, message: $message, messageType: $messageType)';
  }

  @override
  List<Object> get props {
    return [
      senderId,
      senderEmail,
      receiverId,
      createdAt,
      message,
      messageType,
    ];
  }
}
