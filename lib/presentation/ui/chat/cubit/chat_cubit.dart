import 'dart:async';

import 'package:chatting/core/data/utils/constants.dart';
import 'package:chatting/core/data/utils/time_stamp_utils.dart';
import 'package:chatting/data/chat/model/chat_file_model.dart';
import 'package:chatting/data/chat/model/chat_image_model.dart';
import 'package:chatting/data/chat/model/chat_list_model.dart';
import 'package:chatting/data/chat/model/chat_message.dart';
import 'package:chatting/data/chat/model/chat_message_interface.dart';
import 'package:chatting/data/chat/model/chat_message_text.dart';
import 'package:chatting/presentation/ui/chat/cubit/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../data/chat/repo/ChatRepo.dart';

class ChatCubit extends Cubit<ChatState> {

  final ChatRepo chatRepo;
  final ChatModel selectedChat;

  StreamSubscription<List<ChatMessageModel>>? _messagesStream;

  ChatCubit(super.initialState, this.chatRepo,this.selectedChat){
    print('SelectedChat is =${selectedChat.chatId}');
    getMessagesStream();
  }

  void prepareMessage(ChatInterface chatMessageModel){
    if (chatMessageModel is MessageText){
      _sendTextMessage(chatMessageModel.text);
    }else if(chatMessageModel is ImageModel){
      _sendImageMessage(chatMessageModel);
    }else if(chatMessageModel is FileDocumentModel){
      _sendFileDocumentMessage(chatMessageModel);
    }
  }

  void _sendTextMessage(String text) {
    print('sendMessage func tesxt=$text');
    if (text.isEmpty) return;

    Timestamp currentTimestamp = Timestamp.now();
    String messageId = generateMessageId(currentTimestamp);

    ChatMessageModel newMessage = ChatMessageModel(
        message: text,
        messageId: messageId,
        messageType: Constants.textMessage,
        uploaded: Constants.messageNotUploaded,
        edited: 0,
        deleted: 0,
        replyMessageId: null,
        senderId: 'userId1',
        sentAt: currentTimestamp,
        lastModified: currentTimestamp, chatId: selectedChat.chatId);

    chatRepo.addNewMessage(newMessage);
  }

  void _sendImageMessage(ImageModel imageModel) {

    Timestamp currentTimestamp = Timestamp.now();
    String messageId = generateMessageId(currentTimestamp);

    ChatMessageModel newMessage = ChatMessageModel(
        imageModel: imageModel.copyWith(messageId: messageId),
        message: 'Image',
        messageId: messageId,
        messageType: Constants.imageMessage,
        uploaded: Constants.messageNotUploaded,
        edited: 0,
        deleted: 0,
        replyMessageId: null,
        senderId: 'userId1',
        sentAt: currentTimestamp,
        lastModified: currentTimestamp, chatId: selectedChat.chatId);

    chatRepo.addImageMessage(newMessage,imageModel.copyWith(messageId: messageId));
  }

  void _sendFileDocumentMessage(FileDocumentModel fileModel) {

    Timestamp currentTimestamp = Timestamp.now();
    String messageId = generateMessageId(currentTimestamp);

    FileDocumentModel fileDocumentModel = fileModel.copyWith(messageId: messageId);

    ChatMessageModel newMessage = ChatMessageModel(
        fileDocumentModel: fileDocumentModel,
        message: 'File',
        messageId: messageId,
        messageType: Constants.documentMessage,
        uploaded: Constants.messageNotUploaded,
        edited: 0,
        deleted: 0,
        replyMessageId: null,
        senderId: 'userId1',
        sentAt: currentTimestamp,
        lastModified: currentTimestamp,
        chatId: selectedChat.chatId);

    chatRepo.addDocumentFileMessage(newMessage,fileDocumentModel);
  }

  String generateMessageId(Timestamp messageTimestamp) {
    var uuid = Uuid();
    String timestamp = TimestampUtils.timestampToString(messageTimestamp);
    String randomId = uuid.v4();
    print('Generated messageId = $timestamp$randomId');
    return '$timestamp$randomId';
  }

  void getMessagesStream(){
    _messagesStream = chatRepo.getMessagesOfChat(chatId: selectedChat.chatId)
        .listen((messagesList) {
        emit(ChatState(messages: messagesList));
    });
  }

  @override
  Future<void> close() {
    _messagesStream?.cancel();
    return super.close();
  }
}