import 'dart:io';

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
    listenToMessages(userId: 'userId1');
  }

  Stream<List<ChatModel>> getChatList({required String userId}) {
    return localDataSource.getChatList();
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

  void listenToMessages({required String userId}) async {
    Timestamp? maxLastModified = await localDataSource.getMessagesMaxLastModified();

    localDataSource.getChatIdsStream().listen((chatIdList) {
      firestoreDataSource
          .getMessages(
              chatIdList: chatIdList,
              lastMessageTimestampReceived: maxLastModified)
          .listen((messagesData) {
        for (var messageModel in messagesData) {
          print('Received messageModel =${messageModel}');
          localDataSource.insertMessages(messageModel);
        }
      });
    });
  }

// Stream<List<ChatMessageModel>> getChatMessage({required String chatId}){
//   //Timestamp latestMessageTimestamp = localDataSource.getLatestMessageTimestamp(chatId);
//   return firestoreDataSource.getMessages(chatId: chatId, lastMessageTimestampReceived: latestMessageTimestamp);
// }
}
