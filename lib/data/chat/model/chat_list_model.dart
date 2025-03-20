import 'package:cloud_firestore/cloud_firestore.dart';

class ChatListModel {
  final String chatId;
  final String chatTitle;
  final String chatImageUrl;
  final Timestamp? lastModified;
  final Timestamp? createdAt;
  final List<String> usersIdList;

  ChatListModel({required this.chatId, required this.chatTitle, required this.chatImageUrl, required this.usersIdList,required this.createdAt, required this.lastModified,});

  /// Convert `Timestamp` to formatted `String`
  String get lastModifiedAsString => lastModified != null
      ? lastModified!.toDate().toString() // You can format it as needed
      : 'N/A';

  String get createdAtAsString => createdAt != null
      ? createdAt!.toDate().toString() // You can format it as needed
      : 'N/A';

  /// Convert Firestore document to ChatListModel
  factory ChatListModel.fromFirestore(Map<String, dynamic> data) {
    return ChatListModel(
      chatId: data['chatTitle'] ?? '',
      chatTitle: data['chatTitle'] ?? '',
      chatImageUrl: data['chatImageUrl'] ?? '',
      lastModified: data['lastModified'] is Timestamp
          ? data['lastModified']
          : null,
      createdAt: data['createdAt'] is Timestamp ? data['createdAt'] : null,
      usersIdList: List<String>.from(data['usersIdList'] ?? []),
    );
  }
}