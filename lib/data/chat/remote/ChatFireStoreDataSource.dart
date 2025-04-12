import 'dart:io';

import 'package:chatting/core/data/networking/api_constants.dart';
import 'package:chatting/core/data/networking/api_result.dart';
import 'package:chatting/core/data/networking/response_code.dart';
import 'package:chatting/core/data/utils/constants.dart';
import 'package:chatting/core/data/utils/utils.dart';
import 'package:chatting/data/chat/model/chat_image_model.dart';
import 'package:chatting/data/chat/model/chat_list_model.dart';
import 'package:chatting/data/chat/model/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../model/chat_file_model.dart';

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

  Future<ApiResult> addImage({required ImageModel imageModel}) async {
    try{
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child("${Constants.imagesStoragePath}/${imageModel.messageId}");

      File file = File(imageModel.localUrl!);
      final result = await imageRef.putFile(file);

      print('File Result = ${result.ref}');

      String fileUrl = await result.ref.getDownloadURL();

      print('File getDownloadURL = ${fileUrl}');

      return ApiResult.success(fileUrl);
    }on Exception catch(error){
      return ApiResult.failure(ErrorHandler().handleError(error));
    }
  }

  Future<ApiResult> addDocument({required FileDocumentModel fileModel}) async {
    try{
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child("${Constants.documentsStoragePath}/${fileModel.fileName}");

      File file = File(fileModel.localUrl!);
      final result = await imageRef.putFile(file);

      print('File Result = ${result.ref}');

      String fileUrl = result.ref.fullPath;

      print('File getDownloadURL = ${fileUrl}');

      return ApiResult.success(fileUrl);
    }on Exception catch(error){
      return ApiResult.failure(ErrorHandler().handleError(error));
    }
  }

  Future<ApiResult> downloadDocument({required FileDocumentModel fileModel}) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final fileRef = storageRef.child(fileModel.serverUrl!);
      final fileMetaData = await fileRef.getMetadata();
      String fileExtension = getFileExtensionFromContentType(fileMetaData.contentType);
      final appDocDir = await getApplicationDocumentsDirectory();
      final filePath = "${appDocDir.absolute}/documents/${fileModel.messageId}.$fileExtension";
      final localFile = File(filePath);
      final file = await fileRef.writeToFile(localFile);

      /**************** File Model Configuration ***********************/
      String fileSize = convertSizeToString(localFile.lengthSync());
      String fileType = fileExtension.replaceFirst('.', '');
      FileDocumentModel fileDocumentModel = FileDocumentModel(messageId: fileModel.messageId,fileSize: fileSize,fileType: fileType,fileName: fileMetaData.name);
      return ApiResult.success(fileDocumentModel);

    } on Exception catch(error){
      return ApiResult.failure(ErrorHandler().handleError(error));
    }
  }
}