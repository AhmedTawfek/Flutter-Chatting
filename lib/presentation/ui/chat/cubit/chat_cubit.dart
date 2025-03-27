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

  int counter = 0;

  void sendMessage(String text) {
    print('sendMessage func tesxt=$text');
    if (text.isEmpty) return;

    DateTime currentTimeStamp = DateTime.timestamp();
    String time = DateFormat('hh:mm a').format(currentTimeStamp);

    bool senderIsMe = (counter % 2 == 0) ? true : false;
    ChatMessageModel newMessage = ChatMessageModel(message: text, messageTimestamp: Timestamp.now(), senderId: 'userId1',senderIsMe:senderIsMe );
    final updatedMessages = List<ChatMessageModel>.from(state.messages)..add(newMessage);

    counter++;
    emit(state.copyWith(messages: updatedMessages, inputText: ''));
  }





}