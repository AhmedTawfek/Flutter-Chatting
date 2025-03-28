
import 'dart:async';

import 'package:chatting/presentation/ui/chat_list/cubit/chat_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/chat/model/chat_list_model.dart';
import '../../../../data/chat/repo/ChatRepo.dart';

class ChatListCubit extends Cubit<ChatListState>{

  StreamSubscription<List<ChatModel>>? _chatListener;

  final ChatRepo chatRepo;

  ChatListCubit(this.chatRepo) : super(const ChatListState.initial()){
    getChats();
  }

  Future<void> getChats() async {
    emit(const ChatListState.loading());

    _chatListener?.cancel();

    _chatListener = chatRepo.getChatList(userId: 'userId1').listen(
            (chatList) {
              for (var chat in chatList){
                print('getChats =${chat.chatTitle}');
              }
              emit(ChatListState.success(chatList));
    });
  }

  @override
  Future<void> close() {
    print('Closed of cubit is called');
    if (_chatListener != null) {
      _chatListener!.cancel();
    }
    return super.close();
  }
}