
import 'package:chatting/core/data/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel{

  final String message;
  final String? messageId = null;
  final Timestamp sentAt;
  final Timestamp? lastModified = null;
  final String senderId;
  final bool senderIsMe;
  final int messageType = Constants.textMessage;
  final bool edited = false;
  final bool deleted = false;
  final String? replyMessageId = null;

  const ChatMessageModel({required this.message,required this.sentAt,required this.senderId,this.senderIsMe = true});

  factory ChatMessageModel.fromFirestore(Map<String, dynamic> data) {
    return ChatMessageModel(
      message: data['message'],
      sentAt: data['sentAt'],
      senderId: data['senderId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'sent_at': sentAt,
      'last_modified': lastModified,
      'sender_id': senderId,
      'message_type': messageType,
      'edited': edited,
      'deleted': deleted,
      'reply_message_id': replyMessageId
    };
  }

  Map<String, dynamic> createNewMessageToFirestore() {
    return {
      'message': message,
      'sentAt': FieldValue.serverTimestamp(),
      'lastModified': FieldValue.serverTimestamp(),
      'senderId': senderId,
      'type': messageType,
      'edited': edited,
      'deleted': deleted,
      'messageId': messageId,
      'replyMessageId': replyMessageId
    };
  }

}