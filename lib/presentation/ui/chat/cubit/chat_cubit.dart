import 'package:chatting/core/data/utils/time_stamp_utils.dart';
import 'package:chatting/data/chat/model/chat_message.dart';
import 'package:chatting/presentation/ui/chat/cubit/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../data/chat/repo/ChatRepo.dart';

class ChatCubit extends Cubit<ChatState>{

  final ChatRepo chatRepo;
  ChatCubit(super.initialState, this.chatRepo);

  void sendMessage(String text) {
    print('sendMessage func tesxt=$text');
    if (text.isEmpty) return;

    DateTime currentTimeStamp = DateTime.timestamp();
    String time = DateFormat('hh:mm a').format(currentTimeStamp);

    ChatMessageModel newMessage = ChatMessageModel(message: text, messageTimestamp: Timestamp.now(), senderId: 'userId1');
    final updatedMessages = List<ChatMessageModel>.from(state.messages)..add(newMessage);

    //emit(state.copyWith(messages: updatedMessages, inputText: ''));
  }





}