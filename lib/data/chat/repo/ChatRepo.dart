import 'package:chatting/data/chat/local/chat_local_data_source.dart';
import 'package:chatting/data/chat/model/chat_list_model.dart';
import 'package:chatting/data/chat/model/chat_message.dart';
import 'package:chatting/data/chat/remote/ChatFireStoreDataSource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepo {
  final ChatFirestoreDataSource firestoreDataSource;
  final ChatLocalDataSource localDataSource;

  const ChatRepo({required this.firestoreDataSource,required this.localDataSource});

  Stream<List<ChatListModel>> getChatList({required String userId}){
    return firestoreDataSource.getChatList(userId: userId);
  }

  Stream<List<ChatMessageModel>> getChatMessage({required String chatId}){
    Timestamp latestMessageTimestamp = localDataSource.getLatestMessageTimestamp(chatId);
    return firestoreDataSource.getMessages(chatId: chatId, lastMessageTimestampReceived: latestMessageTimestamp);
  }



}