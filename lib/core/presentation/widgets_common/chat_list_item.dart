import 'package:chatting/core/presentation/theming/color_manager.dart';
import 'package:chatting/core/presentation/theming/styles.dart';
import 'package:chatting/data/chat/model/chat_list_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatListItem extends StatelessWidget {
  final ChatListModel chatListModel;
  final Function(ChatListModel) onItemClicked;

  const ChatListItem({super.key, required this.chatListModel, required this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: ColorManager.onPrimary
            ),
            child: Material(  // ✅ Wrap with Material to show ripple effect // Keeps original background color
              borderRadius: BorderRadius.circular(10),  // Apply rounded corners to ripple
              color: ColorManager.onPrimary,
              child: InkWell(
                borderRadius: BorderRadius.circular(10), // ✅ Ensures ripple effect respects border radius
                onTap: () {
                  onItemClicked(chatListModel);
                },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      imageUrl: chatListModel.chatImageUrl,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  Text(chatListModel.chatTitle, style: TextStyles.subtitle1.copyWith(color: ColorManager.black)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
