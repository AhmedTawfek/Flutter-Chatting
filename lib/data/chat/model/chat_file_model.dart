
import 'package:chatting/data/chat/model/chat_message_interface.dart';
import 'package:file_picker/file_picker.dart';

class FileDocumentModel implements ChatInterface{

  final String fileName;
  final String fileType;
  final String fileSize;
  final String messageId;
  final String? serverUrl; // We use the serverUrl when we get an image.
  final String? localUrl; // We use the local url when we send the image from my device,

  const FileDocumentModel({required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.messageId,
    this.serverUrl,
    this.localUrl});

  factory FileDocumentModel.fromFile(PlatformFile file){
    return FileDocumentModel(fileName: file.name, fileType: file.extension.toString(), fileSize: file.size.toString(), messageId: '');
  }

  Map<String, dynamic> toLocal() {
    return {
      'file_id': messageId,
      'file_type': fileType,
      'file_size': fileSize,
      'server_url': serverUrl,
      'local_url': localUrl
    };
  }

}