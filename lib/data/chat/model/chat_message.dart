
import 'package:chatting/core/data/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/data/utils/time_stamp_utils.dart';

class ChatMessageModel{

  final String message;
  final String messageId;
  final String chatId;
  final Timestamp sentAt;
  final Timestamp lastModified;
  final String senderId;
  final bool senderIsMe;
  final int messageType;
  final int edited;
  final int deleted;
  final String? replyMessageId;
  final int uploaded;

  const ChatMessageModel({required this.message,required this.messageId,required this.chatId,required this.sentAt,required this.lastModified,required this.senderId,required this.messageType,required this.edited,required this.deleted,required this.replyMessageId,required this.uploaded,this.senderIsMe = true});

  factory ChatMessageModel.fromFirestore(Map<String, dynamic> data) {
    print('ChatMessageModel.fromFirestore Data is =$data');
    return ChatMessageModel(
      message: data['message'],
      messageId: data['messageId'],
      chatId: data['chatId'],
      sentAt: data['sentAt'],
      lastModified: data['lastModified'],
      senderId: data['senderId'],
      messageType: data['messageType'],
      edited: data['edited'] ?? 0,
      deleted: data['deleted'] ?? 0,
      replyMessageId: data['replyMessageId'] ?? '',
      uploaded: Constants.messageUploaded
    );
  }

  Map<String, dynamic> toLocal() {
    return {
      'message': message,
      'message_id': messageId,
      'chat_id': chatId,
      'sent_at': TimestampUtils.timestampToString(sentAt),
      'last_modified': TimestampUtils.timestampToString(lastModified),
      'sender_id': senderId,
      'message_type': messageType,
      'edited': edited,
      'deleted': deleted,
      'reply_message_id': replyMessageId,
      'uploaded': uploaded
    };
  }

  factory ChatMessageModel.fromLocal(Map<String, dynamic> data) {
    return ChatMessageModel(
      messageId: data['message_id'],
      chatId: data['chat_id'],
      message: data['message'],
      sentAt: TimestampUtils.stringToTimestamp(data['sent_at']),
      lastModified: TimestampUtils.stringToTimestamp(data['last_modified']),
      senderId: data['sender_id'],
      messageType: data['message_type'],
      edited: data['edited'] ?? 0, // Defaults to false if null
      deleted: data['deleted'] ?? 0, // Defaults to false if null
      replyMessageId: data['reply_message_id'],
      uploaded: data['uploaded'] ?? false, // Defaults to false if null
    );
  }


  Map<String, dynamic> createNewMessageToFirestore() {
    return {
      'message': message,
      'messageId': messageId,
      'chatId': chatId,
      'sentAt': sentAt,
      'lastModified': lastModified,
      'senderId': senderId,
      'messageType': messageType,
      'edited': edited,
      'deleted': deleted,
      'replyMessageId': replyMessageId
    };
  }

}