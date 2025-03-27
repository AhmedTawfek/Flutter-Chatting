import 'package:chatting/core/data/utils/constants.dart';
import 'package:chatting/core/presentation/theming/color_manager.dart';
import 'package:chatting/data/chat/model/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/styles.dart';

class PrimaryChatMessageBubble extends StatefulWidget {
  final String messageText;
  final bool isSender;
  final String? messageTime;
  final int index;
  final int messageType = Constants.textMessage;
  final Function(int) replyCallback;

  const PrimaryChatMessageBubble({
    super.key,
    required this.messageText,
    required this.isSender,
    required this.index,
    this.messageTime,
    required this.replyCallback,
  });

  @override
  State<PrimaryChatMessageBubble> createState() =>
      _PrimaryChatMessageBubbleState();
}

class _PrimaryChatMessageBubbleState extends State<PrimaryChatMessageBubble> {
  final MenuController _menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    return
      Align(
      alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: MenuAnchor(
        controller: _menuController,
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(ColorManager.onPrimary),
          elevation: const WidgetStatePropertyAll(4.0),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        menuChildren: _popUpMenu(),
        child: InkWell(
          onLongPress: () {
            final box = context.findRenderObject() as RenderBox;
            final xPosition = (box.paintBounds.topCenter / 3);
            final yPosition = box.paintBounds.topLeft;
            print('PaintBounds = ${box.paintBounds.top}');
            final position = box.localToGlobal(Offset.zero);
            print('localToGlobal = ${position}');
            _menuController.open();
          },
          //onTapDown: (details) => _menuController.open(position: details.globalPosition),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Material(
              elevation: 2,
              shadowColor: widget.isSender
                  ? ColorManager.primary
                  : ColorManager.onPrimary,
              color: widget.isSender
                  ? ColorManager.primary
                  : ColorManager.onPrimary,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.messageType == Constants.textMessage)
                      _textMessage(),
                    _timeMessage(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  final GlobalKey _messageKey = GlobalKey();

  void _openMenu(BuildContext context) {
    // Close any existing menu first
    _menuController.close();

    // Add slight delay to allow menu to close properly
    Future.delayed(const Duration(milliseconds: 50), () {
      final renderBox =
          _messageKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        // Calculate position to show menu above the message
        final menuPosition = Offset(
          position.dx,
          position.dy - renderBox.size.height,
        );
        _menuController.open(position: menuPosition);
      }
    });
  }

  Widget _textMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
      child: Text(
        widget.messageText,
        style: TextStyles.heading6.copyWith(
          color: widget.isSender ? ColorManager.onPrimary : ColorManager.black,
        ),
      ),
    );
  }

  Widget _timeMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 4, right: 10, left: 10, bottom: 5),
          child: Text(
            widget.messageTime ?? '9:45 PM',
            style: TextStyles.subtitle5.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 8.sp,
                color: widget.isSender
                    ? ColorManager.grey
                    : ColorManager.darkGrey2),
          ),
        ),
      ],
    );
  }

  List<Widget> _popUpMenu() {
    return [
      MenuItemButton(
        onPressed: () => _handleMenuSelection('copy'),
        child: const Text('Copy'),
      ),
      if (widget.isSender)
        MenuItemButton(
          onPressed: () => _handleMenuSelection('edit'),
          child: const Text('Edit'),
        ),
      MenuItemButton(
        onPressed: () => _handleMenuSelection('reply'),
        child: const Text('Reply'),
      ),
      if (widget.isSender) // Only show delete for non-sender messages
        MenuItemButton(
          onPressed: () => _handleMenuSelection('delete'),
          child: const Text('Delete'),
        ), // Optional: Add sender-specific actions
    ];
  }

  void _handleMenuSelection(String value) {
    _menuController.close();
    switch (value) {
      case 'reply':
        widget.replyCallback(widget.index);
        // Handle reply
        break;
      case 'copy':
        // Handle copy
        break;
      case 'delete':
        // Handle delete
        break;
    }
  }
}
