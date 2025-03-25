import 'package:chatting/core/data/networking/api_constants.dart';
import 'package:chatting/data/chat/model/chat_list_model.dart';
import 'package:chatting/data/chat/model/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatFirestoreDataSource {
  Stream<List<ChatListModel>> getChatList({required String userId}) {
    return FirebaseFirestore.instance
        .collection(ApiConstants.chatsCollection)
        .where('users', arrayContains: userId)
        .orderBy("createdAt")
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((document) => ChatListModel.fromFirestore(document.data()))
            .toList());
  }

  Stream<List<ChatMessageModel>> getMessages({required String chatId, required Timestamp lastMessageTimestampReceived}) {
    return FirebaseFirestore.instance
        .collection(ApiConstants.chatsCollection)
        .doc(chatId)
        .collection(ApiConstants.messagesCollection)
        .where('sentAt', isGreaterThan: lastMessageTimestampReceived)
        .orderBy('createdAt')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((document) => ChatMessageModel.fromFirestore(document.data()))
            .toList());
  }
  
  Future<void> addMessage({required String chatId,required ChatMessageModel messageModel}) async{
    
      await FirebaseFirestore.instance
          .collection(ApiConstants.chatsCollection)
          .doc(chatId)
          .collection(ApiConstants.messagesCollection)
          .add(messageModel.toFirestore());
    
  }
}
