
class ChatMessage{
  final String message;
  final String messageTimestamp;
  final String? senderId;
  final bool senderIsMe;

  const ChatMessage({required this.message,required this.messageTimestamp,this.senderId,required this.senderIsMe});
}