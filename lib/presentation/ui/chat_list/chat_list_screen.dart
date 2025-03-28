import 'package:chatting/core/presentation/theming/color_manager.dart';
import 'package:chatting/core/presentation/widgets_common/chat_list_item.dart';
import 'package:chatting/data/chat/model/chat_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/routing/routes.dart';
import '../../../core/presentation/theming/styles.dart';
import 'cubit/chat_list_cubit.dart';
import 'cubit/chat_list_state.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<ChatModel> chatListModel = [
    ChatModel(
        chatId: '',
        chatTitle: 'Chat 1',
        chatImageUrl:
            'https://plus.unsplash.com/premium_photo-1710849581742-f2151607c745?q=80&w=1915&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        lastModified: null,
        createdAt: null),
    ChatModel(
        chatId: '',
        chatTitle: 'Chat 2',
        chatImageUrl: '',
        lastModified: null,
        createdAt: null),
    ChatModel(
        chatId: '',
        chatTitle: 'Chat 3',
        chatImageUrl: '',
        lastModified: null,
        createdAt: null)
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body:
        BlocBuilder<ChatListCubit, ChatListState>(builder: (context, state) {
          if (state is Loading){
            return const Center(
              child: CircularProgressIndicator(
                color: ColorManager.primary,
              ),
            );
          }else if(state is Success){
            return chatListWidget(
              state.data
            );
          }else{
            return const Center(
              child: Text("Couldn't load the chat list."),
            );
          }
    })));
  }

  Widget chatListWidget(List<ChatModel> chatList) {
    return Container(
      color: ColorManager.background,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text('Chats', style: TextStyles.heading2),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                return ChatListItem(chatListModel: chatList[index],onItemClicked: (chatListModel){
                  Navigator.of(context).pushNamed(Routes.chatScreen,arguments: chatListModel);
                },);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
          ),
        ],
      ),
    );
  }
}