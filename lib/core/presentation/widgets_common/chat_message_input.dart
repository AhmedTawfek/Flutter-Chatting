import 'package:chatting/core/presentation/widgets_common/primary_text_field.dart';
import 'package:flutter/material.dart';

import '../theming/color_manager.dart';

class ChatMessageInput extends StatefulWidget {
  const ChatMessageInput({super.key});

  @override
  State<ChatMessageInput> createState() => _ChatMessageInputState();
}

class _ChatMessageInputState extends State<ChatMessageInput>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();

  bool _showSendButton = false;

  late AnimationController _animationController;
  late Animation<double> _paddingAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _paddingAnimation = Tween<double>(begin: 0, end: 48).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0), // Offscreen
      end: const Offset(0, 0), // In position
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _toggleSendButton(bool show) {
    if (show && !_showSendButton) {
      setState(() => _showSendButton = true);
      _animationController.forward();
    } else if (!show && _showSendButton) {
      _animationController.reverse().whenComplete(() {
        setState(() => _showSendButton = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: _paddingAnimation.value),
                child: PrimaryTextField(
                  hintText: 'Type here ...',
                  onTextChange: (value) => _toggleSendButton(value.isNotEmpty),
                ),
              ),
            ),
            // Always keep the button in the tree, just slide it
            SlideTransition(
              position: _slideAnimation,
              child: IconButton(
                onPressed: () {
                  // Handle sending message logic
                },
                icon: const Icon(Icons.send, color: ColorManager.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
