import 'package:chatting/core/presentation/widgets_common/chat_message_bubble.dart';
import 'package:chatting/core/presentation/widgets_common/chat_message_input.dart';
import 'package:chatting/presentation/ui/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/theming/color_manager.dart';
import '../../../core/presentation/widgets_common/primary_text_field.dart';
import 'cubit/chat_state.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Initialize the GlobalKey in the State class
  final GlobalKey<PrimaryTextFieldState> _textFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
          print(
              'Chat input=${state.inputText} Messages list =${state.messages}');
          return Column(
            children: [
              // Top Bar
              Card(
                elevation: 2,
                color: ColorManager.background,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Text('Chat Title'),
                    ],
                  ),
                ),
              ),

              // Chat Messages Area
              Expanded(
                child: ListView.builder(
                  reverse: true, // To show latest messages at the bottom
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    return PrimaryChatMessageBubble(
                      messageText: message.message,
                      isSender: message.senderIsMe,
                      messageTime: message.messageTimestamp,
                    );
                  },
                ),
              ),

              // Bottom Input Area
              Card(
                elevation: 2,
                color: ColorManager.background,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ChatMessageInput(
                    globalKey: _textFieldKey,
                    currentMessageInput: state.inputText,
                    onSendButtonPressed: (messageText) => {
                      context.read<ChatCubit>().sendMessage(messageText),
                      _textFieldKey.currentState?.clearText()
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
