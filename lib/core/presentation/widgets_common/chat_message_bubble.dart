import 'package:chatting/core/data/utils/constants.dart';
import 'package:chatting/core/presentation/theming/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/styles.dart';

class PrimaryChatMessageBubble extends StatelessWidget {
  final String messageText;
  final bool isSender;
  final String? messageTime;
  final int messageType = Constants.textMessage;

  const PrimaryChatMessageBubble({
    super.key,
    required this.messageText,
    required this.isSender,
    this.messageTime,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Material(
            color: isSender ? ColorManager.primary : ColorManager.onPrimary,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
                onLongPress: () {
                  _popupMenuMessage(context);
                },
                child: IntrinsicWidth( // Using IntrinsicWidth to prevent any widget from taking the whole height or width.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (messageType == Constants.textMessage) _textMessage(),
                      _timeMessage()
                    ],
                  ),
                ))),
      ),
    );
  }

  Widget _textMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
      child: Text(
        messageText,
        style: TextStyles.heading6.copyWith(
          color: isSender ? ColorManager.onPrimary : ColorManager.black,
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
                '9:45 PM',
                style: TextStyles.subtitle5.copyWith(fontSize: 8.sp),
              ))
        ]);
  }

  // Modified popup menu function to accept context
  void _popupMenuMessage(BuildContext context) {

    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx, // Left position
        position.dy + box.size.height, // Top position
        overlay.size.width - (position.dx + box.size.width), // Right position
        overlay.size.height - position.dy, // Bottom position
      ),
      items: <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: Text('Reply'),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: Text('Copy'),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemThree,
          child: Text('Delete'),
        ),
      ],
    ).then((value) {
      // Handle the selected menu item here
      if (value != null) {
        switch (value) {
          case SampleItem.itemOne:
          // Handle reply
            break;
          case SampleItem.itemTwo:
          // Handle copy
            break;
          case SampleItem.itemThree:
          // Handle delete
            break;
        }
      }
    });
  }
}

enum SampleItem { itemOne, itemTwo, itemThree }
