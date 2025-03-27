import 'package:chatting/core/presentation/theming/styles.dart';
import 'package:chatting/core/presentation/widgets_common/primary_text_field.dart';
import 'package:chatting/data/chat/model/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/color_manager.dart';

class ChatMessageInput extends StatefulWidget {
  String currentMessageInput;
  ChatMessageModel? replyToMessage;

  final Function(String)? onSendButtonPressed;
  final GlobalKey<PrimaryTextFieldState>? globalKey;
  final GlobalKey<ChatMessageInputState>? chatMessageInputState;

  ChatMessageInput(
      {this.chatMessageInputState,
      required this.onSendButtonPressed,
      required this.currentMessageInput,
      this.globalKey}) : super(key: chatMessageInputState);

  @override
  State<ChatMessageInput> createState() => ChatMessageInputState();
}

class ChatMessageInputState extends State<ChatMessageInput> {
  final TextEditingController _controller = TextEditingController();

  bool _showSendButton = false;
  bool _showReplyLayout = false;

  void _showOrHideSendButton(bool show) {
    if (show && !_showSendButton) {
      setState(() {
        _showSendButton = true;
      });
    } else if (!show && _showSendButton) {
      setState(() {
        _showSendButton = false;
      });
    }
  }

  void setReplyToMessage(ChatMessageModel replyToMessageModel){
    widget.replyToMessage = replyToMessageModel;
    _showReplyLayout = false; // This helps us to re-render the reply layout, if there's already an reply layout is shown
    _showOrHideReplyLayout(true);
  }

  void _showOrHideReplyLayout(bool show) {
    if (show && !_showReplyLayout) {
      setState(() {
        _showReplyLayout = true;
      });
    } else if (!show && _showReplyLayout) {
      setState(() {
        _showReplyLayout = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (_showReplyLayout) _replyMessageLayout(),
      Row(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
              margin: EdgeInsets.only(right: _showSendButton ? 8 : 0),
              child: PrimaryTextField(
                globalKey: widget.globalKey,
                hintText: 'Type here ...',
                onTextChange: (value) => {
                  widget.currentMessageInput = value,
                  _showOrHideSendButton(value.isNotEmpty)
                },
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorManager.grey),
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
            child: _showSendButton
                ? AnimatedSlide(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                    offset:
                        _showSendButton ? Offset.zero : const Offset(1.5, 0),
                    child: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        widget.onSendButtonPressed!(widget.currentMessageInput);
                        // Handle button press
                      },
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      )
    ]);
  }

  Widget _replyMessageLayout() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 2,
          color: ColorManager.black,
          child: Row(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reply to name',
                        style: TextStyles.subtitle4.copyWith(
                            fontSize: 11.sp,
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(widget.replyToMessage?.message ?? '',
                          style: TextStyles.subtitle4
                              .copyWith(color: Colors.white))
                    ],
                  )),
              Expanded(child: SizedBox()),
              _cancelButton()
            ],
          ),
        ));
  }

  Widget _cancelButton() {
    return IconButton(
        onPressed: () {
          _showOrHideReplyLayout(false);
        },
        icon: const Icon(Icons.cancel, color: ColorManager.background));
  }
}
