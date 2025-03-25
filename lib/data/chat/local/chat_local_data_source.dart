
import 'package:chatting/core/data/local/local_storage_data_source.dart';
import 'package:chatting/core/data/utils/time_stamp_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatLocalDataSource{
  final LocalStorageDataSource localInstance;

  const ChatLocalDataSource({required this.localInstance});

  Future<void> saveLatestMessageTimestamp(String chatId,Timestamp latestTimestamp) async{
    String timestampToString = TimestampUtils.timestampToString(latestTimestamp);
    return await localInstance.saveValue(chatId, timestampToString);
  }

  Timestamp getLatestMessageTimestamp(String chatId){
    String? latestTimestampAsString = localInstance.getValue(chatId, null);

    if (latestTimestampAsString == null) return TimestampUtils.getMinimumTimestamp();

    return TimestampUtils.stringToTimestamp(latestTimestampAsString);
  }
}