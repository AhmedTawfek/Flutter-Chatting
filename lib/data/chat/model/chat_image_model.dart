
import 'package:chatting/data/chat/model/chat_message.dart';
import 'package:chatting/data/chat/model/chat_message_interface.dart';

class ImageModel implements ChatInterface{
  final String messageId;
  final String? serverUrl; // We use the serverUrl when we get an image.
  final String? localUrl; // We use the local url when we send the image from my device,

  const ImageModel({
    required this.messageId,
    this.serverUrl,
    this.localUrl,
  });

  // factory ImageModel.fromChatMessage(ChatMessageModel messageModel){
  //   return ImageModel(messageId: messageModel.messageId,serverUrl: )
  // }

  factory ImageModel.fromLocal(Map<String, dynamic> map) {
    return ImageModel(
      messageId: map['message_id'],
      serverUrl: map['server_url'],
      localUrl: map['local_url'],
    );
  }

  Map<String, dynamic> toLocal() {
    return {
      'message_id': messageId,
      'server_url': serverUrl,
      'local_url': localUrl
    };
  }

  ImageModel copyWith({
    String? messageId,
    String? serverUrl,
    String? localUrl,
  }) {
    return ImageModel(
      messageId: messageId ?? this.messageId,
      serverUrl: serverUrl ?? this.serverUrl,
      localUrl: localUrl ?? this.localUrl,
    );
  }
}