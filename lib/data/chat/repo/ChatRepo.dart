import 'dart:io';

import 'package:chatting/core/data/networking/api_result.dart';
import 'package:chatting/data/chat/local/chat_local_data_source.dart';
import 'package:chatting/data/chat/model/chat_list_model.dart';
import 'package:chatting/data/chat/model/chat_message.dart';
import 'package:chatting/data/chat/remote/ChatFireStoreDataSource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepo {
  final ChatFirestoreDataSource firestoreDataSource;
  final ChatLocalDataSource localDataSource;

  ChatRepo({required this.firestoreDataSource, required this.localDataSource}) {
    listenToChatsAndInsertLocally(userId: 'userId1');
    _listenToMessages(userId: 'userId1');
  }

  Stream<List<ChatModel>> getChatList({required String userId}) {
    return localDataSource.getChatListStream();
  }

  void listenToChatsAndInsertLocally({required String userId}) async {
    Timestamp? maxLastModified =
        await localDataSource.getChatsMaxLastModified();
    try {
      firestoreDataSource
          .getChatList(userId: userId, lastModified: maxLastModified)
          .listen((chatList) async {
        for (var chatModel in chatList) {
          await localDataSource.insertChat(chatModel);
        }
      });
    } on IOException catch (error) {
      print('Error happened ${error}');
    }
  }

  void _listenToMessages({required String userId}) async {

    Timestamp? maxLastModified = await localDataSource.getMessagesMaxLastModified();
    // If we are getting the messages for first time, we need to get all messages that are stored on server
    // But, after that we don't want to listen for the messages that we already sent, because we already added them locally.
    bool skipMyUserMessages = (maxLastModified == null ? false : true);

    localDataSource.getChatIdsStream().listen((chatIdList) {
      print('getChatIdsStream =$chatIdList');

      firestoreDataSource
          .getMessages(
              chatIdList: chatIdList,
              lastMessageTimestampReceived: maxLastModified,
              currentUserId: 'userId1',
              skipMyUserIdMessage: skipMyUserMessages)
          .listen((messagesData) {

        for (var messageModel in messagesData) {
          if (skipMyUserMessages && messageModel.senderId == userId) continue;

          print('Received messageModel =${messageModel}');
          localDataSource.insertMessages(messageModel);
        }
      });
    });
  }

  void addNewMessage(ChatMessageModel messageModel) async {
    final messageInserted = await localDataSource.insertMessages(messageModel);

    if (messageInserted != -1) {
      ApiResult addingMessageResult = await firestoreDataSource.addMessage(messageModel: messageModel);

      if (addingMessageResult is Success){
          localDataSource.setMessageAsUploaded(messageModel);
      }
    }
  }

  Stream<List<ChatMessageModel>> getMessagesOfChat({required String chatId}){
    return localDataSource.getMessagesOfChatStream(chatId: chatId);
  }

// Stream<List<ChatMessageModel>> getChatMessage({required String chatId}){
//   //Timestamp latestMessageTimestamp = localDataSource.getLatestMessageTimestamp(chatId);
//   return firestoreDataSource.getMessages(chatId: chatId, lastMessageTimestampReceived: latestMessageTimestamp);
// }
}
