
import 'package:chatting/core/data/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel{

  final String message;
  final String? messageId = null;
  final Timestamp messageTimestamp;
  final Timestamp? lastModified = null;
  final String senderId;
  final bool senderIsMe;
  final int messageType = Constants.textMessage;
  final bool edited = false;
  final bool deleted = false;

  const ChatMessageModel({required this.message,required this.messageTimestamp,required this.senderId,this.senderIsMe = true});

  factory ChatMessageModel.fromFirestore(Map<String, dynamic> data) {
    return ChatMessageModel(
      message: data['message'],
      messageTimestamp: data['sentAt'],
      senderId: data['senderId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'message': message,
      'sentAt': messageTimestamp,
      'lastModified': FieldValue.serverTimestamp(),
      'senderId': senderId,
      'type': messageType,
      'edited': edited,
      'deleted': deleted,
      'messageId': messageId
    };
  }
}