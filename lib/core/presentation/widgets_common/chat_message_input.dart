import 'package:chatting/core/presentation/widgets_common/primary_text_field.dart';
import 'package:flutter/material.dart';

import '../theming/color_manager.dart';

class ChatMessageInput extends StatefulWidget {

  String currentMessageInput;
  final Function(String)? onSendButtonPressed;
  final GlobalKey<PrimaryTextFieldState>? globalKey;

  ChatMessageInput({super.key,required this.onSendButtonPressed,required this.currentMessageInput, this.globalKey});

  @override
  State<ChatMessageInput> createState() => _ChatMessageInputState();
}

class _ChatMessageInputState extends State<ChatMessageInput> {
  final TextEditingController _controller = TextEditingController();

  bool _showSendButton = false;

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

  @override
  Widget build(BuildContext context) {
    return Row(
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
                borderRadius: BorderRadius.circular(15.0)
              ),
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
                  offset: _showSendButton ? Offset.zero : const Offset(1.5, 0),
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
    );
  }
}