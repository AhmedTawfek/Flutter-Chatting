
import 'package:chatting/presentation/ui/chat_list/cubit/chat_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/chat/repo/ChatRepo.dart';

class ChatListCubit extends Cubit<ChatListState>{

  final ChatRepo chatRepo;

  ChatListCubit(this.chatRepo) : super(const ChatListState.initial()){
    getChats();
  }

  void getChats(){
    print('Entered getChats');
    chatRepo.getChatList(userId: 'userId1').listen((onData) {
        print('getChats =$onData');
    });
  }

}