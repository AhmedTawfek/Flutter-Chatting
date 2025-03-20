import 'package:chatting/core/presentation/theming/color_manager.dart';
import 'package:flutter/material.dart';

import '../theming/styles.dart';

class PrimaryChatMessageBubble extends StatelessWidget {
  final String messageText;
  final bool isSender;
  final String? messageTime;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isSender ? ColorManager.primary : ColorManager.background,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                messageText,
                style: TextStyles.heading6.copyWith(
                  color: isSender ? ColorManager.onPrimary : ColorManager.black,
                ),
              ),
            ),
          ),
          if (messageTime != null)
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                messageTime ?? '',
                style: TextStyles.subtitle5,
              ),
            )
        ],
      ),
    );
  }
}