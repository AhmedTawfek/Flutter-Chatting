
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel{
  final String message;
  final Timestamp messageTimestamp;
  final String senderId;
  final bool senderIsMe;

  const ChatMessageModel( {required this.message,required this.messageTimestamp,required this.senderId,this.senderIsMe = false});

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
      'sentAt': messageTimestamp, // ✅ Firestore understands Timestamp
      'senderId': senderId,
    };
  }
}