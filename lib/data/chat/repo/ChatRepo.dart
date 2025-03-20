import 'package:chatting/data/chat/model/chat_list_model.dart';
import 'package:chatting/data/chat/remote/ChatFireStoreDataSource.dart';

class ChatRepo {

  final ChatFirestoreDataSource firestoreDataSource;

  const ChatRepo(this.firestoreDataSource);

  Stream<List<ChatListModel>> getChatList({required String userId}) {
    return firestoreDataSource.getChatList(userId: userId);
  }

}