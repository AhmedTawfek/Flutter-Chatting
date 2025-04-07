import 'package:chatting/core/presentation/widgets_common/chat_message_bubble.dart';
import 'package:chatting/core/presentation/widgets_common/chat_message_input.dart';
import 'package:chatting/data/chat/model/chat_list_model.dart';
import 'package:chatting/presentation/ui/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/theming/color_manager.dart';
import '../../../core/presentation/widgets_common/primary_text_field.dart';
import 'cubit/chat_state.dart';

class ChatScreen extends StatefulWidget {

  final ChatModel selectedChatListModel;

  const ChatScreen({super.key,required this.selectedChatListModel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Initialize the GlobalKey in the State class
  final GlobalKey<PrimaryTextFieldState> _textFieldKey = GlobalKey();
  final GlobalKey<ChatMessageInputState> _chatMessageInputKey = GlobalKey();

  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onDetach: (){
        print('State of Chat screen On detach is called');
      },
        onShow: (){
        print('State of Chat screen onShow is called');
        },
        onHide: (){
        print('State of Chat screen onHide is called');
        },
        onRestart: (){
        print('State of Chat screen onRestart is called');
        },
      onStateChange: (state){
        print('State of Chat screen is =$state');
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        body: OverlayBoundary(child:
        BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
          print('Chat input=${state.inputText} Messages list =${state.messages}');
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
                      Text(widget.selectedChatListModel.chatTitle),
                    ],
                  ),
                ),
              ),

              // Chat Messages Area
              Expanded(child:

              ListView.builder(
                  reverse: true, // To show latest messages at the bottom
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    return PrimaryChatMessageBubble(
                      index: index,
                      messageModel: message,
                      myUserId: 'userId1',
                      replyCallback: (selectedMessageIndex){
                        _chatMessageInputKey.currentState?.setReplyToMessage(state.messages[selectedMessageIndex]);
                      },
                      //messageTime: message.messageTimestamp,
                    );
                  },
                ),
              ),

              // Bottom Input Area
              Card(
                elevation: 0,
                color: ColorManager.background,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                  ),
                ),
                child: ChatMessageInput(
                  chatMessageInputState: _chatMessageInputKey,
                    globalKey: _textFieldKey,
                    currentMessageInput: state.inputText,
                    onSendButtonPressed: (messageText) => {
                      context.read<ChatCubit>().sendTextMessage(messageText),
                      _textFieldKey.currentState?.clearText()
                    },
                  ),
                ),
            ],
          );
        }),
      ),
    ));
  }
}


class OverlayBoundary extends StatefulWidget {
  const OverlayBoundary({super.key, required this.child});

  final Widget child;

  @override
  State<OverlayBoundary> createState() => _OverlayBoundaryState();
}
class _OverlayBoundaryState extends State<OverlayBoundary> {
  late final OverlayEntry _overlayEntry = OverlayEntry(builder: (context) => widget.child);

  @override
  void didUpdateWidget(covariant OverlayBoundary oldWidget) {
    super.didUpdateWidget(oldWidget);
    _overlayEntry.markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [_overlayEntry],
    );
  }
}