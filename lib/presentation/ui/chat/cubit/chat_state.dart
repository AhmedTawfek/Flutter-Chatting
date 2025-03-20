import 'package:chatting/data/chat/model/chat_message.dart';
import 'package:chatting/data/chat/model/chat_room_details.dart';

class ChatState {
  final List<ChatMessage> messages;
  final String inputText;
  final ChatRoomDetails? chatDetails;
  final bool isLoading;
  final String? errorMessage;

  ChatState({
    this.messages = const [],
    this.inputText = '',
    this.chatDetails,
    this.isLoading = false,
    this.errorMessage,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    String? inputText,
    ChatRoomDetails? chatDetails,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      inputText: inputText ?? this.inputText,
      chatDetails: chatDetails ?? this.chatDetails,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}