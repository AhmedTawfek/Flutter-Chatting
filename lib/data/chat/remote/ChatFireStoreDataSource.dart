import 'package:chatting/core/data/networking/api_constants.dart';
import 'package:chatting/core/data/networking/api_result.dart';
import 'package:chatting/core/data/networking/response_code.dart';
import 'package:chatting/data/chat/model/chat_list_model.dart';
import 'package:chatting/data/chat/model/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatFirestoreDataSource {

  Stream<List<ChatModel>> getChatList({required String userId,Timestamp? lastModified}) {

    return FirebaseFirestore.instance
        .collection(ApiConstants.chatsCollection)
        .where('users', arrayContains: userId)
        .where('lastModified',isGreaterThan: lastModified)
        .orderBy("createdAt")
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((document) => ChatModel.fromFirestore(document.data()))
            .toList());
  }

  Stream<List<ChatMessageModel>> getMessages({
    required List<String> chatIdList,
    required Timestamp? lastMessageTimestampReceived,
    required String currentUserId,
    bool skipMyUserIdMessage = true
  }){
    return FirebaseFirestore.instance
        .collectionGroup(ApiConstants.messagesCollection)
        .where('chatId', whereIn: chatIdList)
        .where('lastModified', isGreaterThan: lastMessageTimestampReceived)
        .orderBy('lastModified')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
        .map((document) => ChatMessageModel.fromFirestore(document.data()))
        //.where((message) => skipMyUserIdMessage && message.senderId != currentUserId) // Filter out current user
        .toList());
  }
  
  Future<ApiResult> addMessage({required ChatMessageModel messageModel}) async{

      try{
        await FirebaseFirestore.instance
            .collection(ApiConstants.chatsCollection)
            .doc(messageModel.chatId)
            .collection(ApiConstants.messagesCollection)
            .add(messageModel.createNewMessageToFirestore());

        return ApiResult.success(null);

      } on Exception catch(error){
        print('Adding a message to firestore throws error =$error');
        return ApiResult.failure(ErrorHandler().handleError(error));
      }

  }
}