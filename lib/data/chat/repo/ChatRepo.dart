import 'dart:io';

import 'package:chatting/core/data/networking/api_result.dart';
import 'package:chatting/core/data/networking/response_code.dart';
import 'package:chatting/core/data/utils/constants.dart';
import 'package:chatting/data/chat/local/chat_local_data_source.dart';
import 'package:chatting/data/chat/model/chat_file_model.dart';
import 'package:chatting/data/chat/model/chat_image_model.dart';
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
    Timestamp? maxLastModified =
        await localDataSource.getMessagesMaxLastModified();
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

          if (messageModel.messageType == Constants.textMessage) {
            print('Received messageModel =${messageModel}');
            localDataSource.insertMessages(messageModel);
          }else if(messageModel.messageType == Constants.imageMessage){
            _insertImageModelLocally(messageModel);
          }else if(messageModel.messageType == Constants.documentMessage){

          }
        }
      });
    });
  }

  // Future<ApiResult> _downloadDocumentAndInsertLocally(ChatMessageModel messageModel) async{
  //
  // }

  Future<ApiResult> _insertImageModelLocally(ChatMessageModel messageModel) async{
    int imageInsertingResult = await localDataSource.insertImage(messageModel.imageModel!);

    if (imageInsertingResult <= 0) {
      return ApiResult.failure(ApiError.unKnown());
    }

    int messageInsertingResult = await localDataSource.insertMessages(messageModel);

    if (messageInsertingResult <= 0){
      return ApiResult.failure(ApiError.unKnown());
    }else{
      return ApiResult.success(null);
    }
  }

  Future<ApiResult> _addMessageToFirestore(
      ChatMessageModel messageModel) async {
    ApiResult addingMessageResult =
        await firestoreDataSource.addMessage(messageModel: messageModel);

    if (addingMessageResult is Success) {
      localDataSource.setMessageAsUploaded(messageModel);
    }

    return addingMessageResult;
  }

  void addNewMessage(ChatMessageModel messageModel) async {
    final messageInserted = await localDataSource.insertMessages(messageModel);

    if (messageInserted != -1) {
      _addMessageToFirestore(messageModel);
    }
  }

  Future<ApiResult> addImageMessage(ChatMessageModel messageModel, ImageModel imageModel) async {
    int imageInsertingResult = await localDataSource.insertImage(imageModel);

    if (imageInsertingResult <= 0) {
      return ApiResult.failure(ApiError.unKnown());
    }

    int messageInsertingResult = await localDataSource.insertMessages(messageModel);

    if (messageInsertingResult != -1) {
      ApiResult addingImageToStorageResult =
          await firestoreDataSource.addImage(imageModel: imageModel);

      if (addingImageToStorageResult is Success) {
        String imageUrlOnServer = addingImageToStorageResult.data;
        ApiResult addingMessageResult = await _addMessageToFirestore(messageModel.copyWith(imageModel: imageModel.copyWith(serverUrl: imageUrlOnServer)));
        return addingMessageResult;
      } else {
        return ApiResult.failure(ApiError.unKnown());
      }
    } else {
      return ApiResult.failure(ApiError.unKnown());
    }
  }

  Future<ApiResult> addDocumentFileMessage(ChatMessageModel messageModel, FileDocumentModel fileModel) async {
    int imageInsertingResult = await localDataSource.insertFile(fileModel);

    if (imageInsertingResult <= 0) {
      return ApiResult.failure(ApiError.unKnown());
    }

    int messageInsertingResult = await localDataSource.insertMessages(messageModel);

    if (messageInsertingResult != -1) {
      ApiResult addingFileToStorageResult = await firestoreDataSource.addDocument(fileModel: fileModel);

      if (addingFileToStorageResult is Success) {
        String fileUrlOnServer = addingFileToStorageResult.data;
        ApiResult addingMessageResult = await _addMessageToFirestore(messageModel.copyWith(fileDocumentModel: fileModel.copyWith(serverUrl: fileUrlOnServer)));
        return addingMessageResult;
      } else {
        return ApiResult.failure(ApiError.unKnown());
      }
    } else {
      return ApiResult.failure(ApiError.unKnown());
    }
  }


  Stream<List<ChatMessageModel>> getMessagesOfChat({required String chatId}) {
    return localDataSource
        .getMessagesOfChatStream(chatId: chatId)
        .asyncMap((data) async {
      for (ChatMessageModel message in data) {

        if (message.messageType == Constants.imageMessage) {
          ImageModel? image = await localDataSource.getImageModelById(message.messageId);
          message.imageModel = image;
        }else if(message.messageType == Constants.documentMessage){
          FileDocumentModel? fileModel = await localDataSource.getDocumentFileModelById(message.messageId);
          message.fileDocumentModel = fileModel;
        }
      }

      return data;
    });
  }

// Stream<List<ChatMessageModel>> getChatMessage({required String chatId}){
//   //Timestamp latestMessageTimestamp = localDataSource.getLatestMessageTimestamp(chatId);
//   return firestoreDataSource.getMessages(chatId: chatId, lastMessageTimestampReceived: latestMessageTimestamp);
// }
}
