
import 'package:chatting/data/chat/model/chat_message_interface.dart';

class MessageText implements ChatInterface{
  final String text;
  const MessageText({required this.text});
}