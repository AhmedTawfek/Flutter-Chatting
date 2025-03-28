import 'package:chatting/core/data/utils/time_stamp_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {

  final String chatId;
  final String chatTitle;
  final String chatImageUrl;
  final Timestamp? lastModified;
  final Timestamp? createdAt;

  ChatModel({required this.chatId, required this.chatTitle, required this.chatImageUrl,required this.createdAt, required this.lastModified,});

  /// Convert `Timestamp` to formatted `String`
  String get lastModifiedAsString => lastModified != null
      ? lastModified!.toDate().toString() // You can format it as needed
      : 'N/A';

  String get createdAtAsString => createdAt != null
      ? createdAt!.toDate().toString() // You can format it as needed
      : 'N/A';

  /// Convert Firestore document to ChatListModel
  factory ChatModel.fromFirestore(Map<String, dynamic> data) {
    return ChatModel(
      chatId: data['chatId'] ?? '',
      chatTitle: data['title'] ?? '',
      chatImageUrl: data['imageUrl'] ?? '',
      lastModified: data['lastModified'] is Timestamp
          ? data['lastModified']
          : null,
      createdAt: data['createdAt'] is Timestamp ? data['createdAt'] : null
    );
  }

  factory ChatModel.fromMap(Map<String, dynamic> data) {
    return ChatModel(
      chatId: data['chat_id'] ?? '',
      chatTitle: data['title'] ?? '',
      chatImageUrl: data['image_url'] ?? '',
      lastModified: data['last_modified'] is Timestamp
          ? data['last_modified']
          : null,
      createdAt: data['created_at'] is Timestamp ? data['created_at'] : null
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chat_id': chatId,
      'title': chatTitle,
      'created_at': TimestampUtils.timestampToString(createdAt),
      'last_modified': TimestampUtils.timestampToString(lastModified),
      'image_url': chatImageUrl,
    };
  }
}