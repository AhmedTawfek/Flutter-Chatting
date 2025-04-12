import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatting/core/data/utils/constants.dart';
import 'package:chatting/core/data/utils/time_stamp_utils.dart';
import 'package:chatting/core/presentation/theming/color_manager.dart';
import 'package:chatting/data/chat/model/chat_file_model.dart';
import 'package:chatting/data/chat/model/chat_image_model.dart';
import 'package:chatting/data/chat/model/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/theming/styles.dart';

class PrimaryChatMessageBubble extends StatefulWidget {
  final ChatMessageModel messageModel;
  final String myUserId;
  final int index;

  bool isSender = false;

  final Function(int) replyCallback;

  PrimaryChatMessageBubble({
    super.key,
    required this.messageModel,
    required this.myUserId,
    required this.index,
    required this.replyCallback,
  }) {
    isSender = (myUserId == messageModel.senderId);
  }

  @override
  State<PrimaryChatMessageBubble> createState() =>
      _PrimaryChatMessageBubbleState();
}

class _PrimaryChatMessageBubbleState extends State<PrimaryChatMessageBubble> {
  final MenuController _menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    return Align(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Material(
            elevation: 3,
            shadowColor:
                widget.isSender ? ColorManager.primary : ColorManager.onPrimary,
            color:
                widget.isSender ? ColorManager.primary : ColorManager.onPrimary,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: InkWell(
              onTap: (){

              },
              onLongPress: () {
                final box = context.findRenderObject() as RenderBox;
                final xPosition = (box.paintBounds.topCenter / 3);
                final yPosition = box.paintBounds.topLeft;
                print('PaintBounds = ${box.paintBounds.top}');
                final position = box.localToGlobal(Offset.zero);
                print('localToGlobal = ${position}');
                _menuController.open();
              },
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.messageModel.messageType == Constants.textMessage)
                      _textMessage(),

                    if (widget.messageModel.messageType == Constants.imageMessage)
                      _imageMessage(context),

                    if (widget.messageModel.messageType == Constants.documentMessage)
                      _documentMessage(widget.messageModel.fileDocumentModel!),

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

  Widget _replyMessage() {
    return InkWell(
        onTap: () {
          print('Reply layout is clicked');
        },
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
            child: Material(
              borderRadius: BorderRadius.circular(15),
              color: ColorManager.black,
              child: Row(
                children: [
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          Text('Reply to message',
                              style: TextStyles.subtitle4
                                  .copyWith(color: Colors.white))
                        ],
                      ))
                ],
              ),
            )));
  }

  Widget _imageMessage(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            width: screenWidth * 0.5, // Set width to 70% of screen width
            height: 200, // Fixed max height
            child: _buildImage(widget.messageModel.imageModel),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(ImageModel? imageModel){
    if (imageModel != null && imageModel.localUrl != null){
      File imageFile = File(imageModel.localUrl!);
      return Image.file(imageFile,fit: BoxFit.cover);
    }else{
      return CachedNetworkImage(
        imageUrl: imageModel?.serverUrl??'https://images.unsplash.com/photo-1569041032556-6485fc04aff0?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        fit: BoxFit.cover, // Ensures the image fills the space correctly
      );
    }
  }

  Widget _documentMessage(FileDocumentModel fileModel) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenWidth * 0.6,
          // No minWidth; it will take the content's width
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.file_copy,
              color: widget.isSender
                  ? ColorManager.onPrimary
                  : ColorManager.primary,
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    fileModel.fileName ?? 'Unknown',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.heading6.copyWith(
                      fontSize: 11.sp,
                      color: widget.isSender
                          ? ColorManager.onPrimary
                          : ColorManager.black,
                    ),
                  ),
                  Text(
                    '${fileModel.fileSize ?? ""} • ${fileModel.fileType ?? ""}',
                    style: TextStyles.heading6.copyWith(
                      fontSize: 10.sp,
                      color: widget.isSender
                          ? ColorManager.grey3
                          : ColorManager.darkGrey2,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _textMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
      child: Text(
        widget.messageModel.message,
        style: TextStyles.heading6.copyWith(
          color: widget.isSender ? ColorManager.onPrimary : ColorManager.black,
        ),
      ),
    );
  }

  Widget _timeMessage() {
    bool messageUploaded =
        (widget.messageModel.uploaded == Constants.messageUploaded);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
            padding: EdgeInsets.only(
                top: 4, right: messageUploaded ? 10 : 3, left: 10, bottom: 5),
            child: Text(
              TimestampUtils.getTimeFromTimestamp(widget.messageModel.sentAt),
              style: TextStyles.subtitle5.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 9.sp,
                  color: widget.isSender
                      ? ColorManager.grey
                      : ColorManager.darkGrey2),
            )),
        if (widget.messageModel.uploaded == Constants.messageNotUploaded)
          Padding(padding: EdgeInsets.only(right: 5,bottom: 2), child: Icon(Icons.pending_outlined,size: 18,color: widget.isSender
              ? ColorManager.grey
              : ColorManager.darkGrey2,)),
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
