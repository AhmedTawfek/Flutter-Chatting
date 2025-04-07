
import 'package:chatting/core/data/local/local_preferences_data_source.dart';
import 'package:chatting/core/data/local/sqlite_data_base.dart';
import 'package:chatting/core/data/utils/time_stamp_utils.dart';
import 'package:chatting/data/chat/model/chat_list_model.dart';
import 'package:chatting/data/chat/model/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlbrite/sqlbrite.dart';


class ChatLocalDataSource{
  
  final SqliteDatabase sqliteInstance;
  
  ChatLocalDataSource({required this.sqliteInstance});

  // Future<void> saveLatestMessageTimestamp(String chatId,Timestamp latestTimestamp) async{
  //   String timestampToString = TimestampUtils.timestampToString(latestTimestamp);
  //   return await localInstance.saveValue(chatId, timestampToString);
  // }
  //
  // Timestamp getLatestMessageTimestamp(String chatId){
  //
  //   String? latestTimestampAsString = localInstance.getValue(chatId, null);
  //
  //   if (latestTimestampAsString == null) return TimestampUtils.getMinimumTimestamp();
  //
  //   return TimestampUtils.stringToTimestamp(latestTimestampAsString);
  // }

  Stream<List<ChatModel>> getChatListStream() {
    return sqliteInstance.database.asStream().asyncExpand((instance) {
      return instance
          .createQuery(SqliteDatabase.chatTable)
          .mapToList((row) => ChatModel.fromMap(row));
    });
  }

  Stream<List<ChatMessageModel>> getMessagesOfChatStream({required String chatId}) {
    return sqliteInstance.database.asStream().asyncExpand((instance) {
      return instance
          .createQuery(SqliteDatabase.messagesTable,
          where: 'chat_id = ?',
          whereArgs: [chatId],
          orderBy: 'sent_at DESC') // Order by sent_at in ascending order
          .mapToList((row) => ChatMessageModel.fromLocal(row));
    });
  }

  Stream<List<String>> getChatIdsStream() {
    return sqliteInstance.database.asStream().asyncExpand((instance) {
      return instance
          .createQuery(SqliteDatabase.chatTable,columns: ['chat_id'])
          .mapToList((row) => row['chat_id'] as String);
    });
  }

  Future<Timestamp?> getChatsMaxLastModified() async {
    final db = await sqliteInstance.database;

    final result = await db.query(
      SqliteDatabase.chatTable,
      columns: ['MAX(last_modified) AS max_last_modified'],
    );
    if (result.isNotEmpty && result.first['max_last_modified'] != null) {
      return TimestampUtils.stringToTimestamp(result.first['max_last_modified'] as String);
    }
    return null; // Return null if no chats exist
  }

  Future<Timestamp?> getMessagesMaxLastModified() async {
    final db = await sqliteInstance.database;

    final result = await db.query(
      SqliteDatabase.messagesTable,
      columns: ['MAX(last_modified) AS max_last_modified'],
    );
    if (result.isNotEmpty && result.first['max_last_modified'] != null) {
      return TimestampUtils.stringToTimestamp(result.first['max_last_modified'] as String);
    }
    return null; // Return null if no chats exist
  }


  Future<int> insertChat(ChatModel chatModel)async{
    final instance = await sqliteInstance.database;
    return instance.insert(SqliteDatabase.chatTable, chatModel.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> insertMessages(ChatMessageModel chatModel)async{
    final instance = await sqliteInstance.database;
    return instance.insert(SqliteDatabase.messagesTable, chatModel.toLocal(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateChat(ChatModel chatModel)async{
    final instance = await sqliteInstance.database;
    return instance.update(
        SqliteDatabase.chatTable,
        chatModel.toMap(),
      where: 'chat_id = ?',
    whereArgs: [chatModel.chatId]);
  }

  Future<int> setMessageAsUploaded(ChatMessageModel messageModel) async {
    final db = await sqliteInstance.database;

    return await db.update(
      'messages', // Your table name
      {'uploaded': 1}, // Column to update
      where: 'message_id = ?', // Where clause to identify the message
      whereArgs: [messageModel.messageId], // Message ID to update
    );
  }

}