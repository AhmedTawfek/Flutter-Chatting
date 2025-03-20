import 'package:chatting/data/chat/model/chat_message.dart';
import 'package:chatting/presentation/ui/chat/cubit/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatCubit extends Cubit<ChatState>{
  ChatCubit(super.initialState);

  void sendMessage(String text) {
    print('sendMessage func tesxt=$text');
    if (text.isEmpty) return;

    DateTime currentTimeStamp = DateTime.timestamp();
    String time = DateFormat('hh:mm a').format(currentTimeStamp);

    ChatMessage newMessage = ChatMessage(message: text, senderIsMe: true,messageTimestamp: time);
    final updatedMessages = List<ChatMessage>.from(state.messages)..add(newMessage);

    emit(state.copyWith(messages: updatedMessages, inputText: ''));
  }

}