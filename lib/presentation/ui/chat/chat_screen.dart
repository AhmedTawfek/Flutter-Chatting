import 'package:chatting/core/presentation/widgets_common/chat_message_bubble.dart';
import 'package:chatting/core/presentation/widgets_common/chat_message_input.dart';
import 'package:flutter/material.dart';

import '../../../core/presentation/theming/color_manager.dart';
import '../../../core/presentation/widgets_common/primary_text_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                  reverse: true,
                  itemCount: 50,
                  itemBuilder: (context,index){
                    return const PrimaryChatMessageBubble(messageText: 'tttttttttesttttttttttest', isSender: true,messageTime: '9:34 PM',);
                  }),
            ),

            // Bottom Input Area
            const Card(
              elevation: 2,
              color: ColorManager.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: ChatMessageInput(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
