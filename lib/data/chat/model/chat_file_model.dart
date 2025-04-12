import 'dart:io';

import 'package:chatting/core/data/utils/constants.dart';
import 'package:chatting/core/data/utils/utils.dart';
import 'package:chatting/data/chat/model/chat_message_interface.dart';
import 'package:file_picker/file_picker.dart';

class FileDocumentModel implements ChatInterface {
  final String? fileName;
  final String? fileType;
  final String? fileSize;
  final String messageId;
  final String? serverUrl; // We use the serverUrl when we get an image.
  final String?localUrl; // We use the local url when we send the image from my device,
  final int fileDownloadState;

  const FileDocumentModel(
      {required this.messageId,
      this.fileName,
      this.fileType,
      this.fileSize,
      this.serverUrl,
      this.localUrl,
      this.fileDownloadState= Constants.fileDownloaded});

  factory FileDocumentModel.fromPlatformFile(PlatformFile file) {
    return FileDocumentModel(
        fileName: file.name,
        fileType: file.extension,
        fileSize: convertSizeToString(file.size),
        localUrl: file.path,
        fileDownloadState: Constants.fileDownloaded,
        messageId: '');
  }

  Map<String, dynamic> toLocal() {
    return {
      'message_id': messageId,
      'file_name':fileName,
      'file_type': fileType,
      'file_size': fileSize,
      'server_url': serverUrl,
      'local_url': localUrl,
      'file_download_state': fileDownloadState
    };
  }

  factory FileDocumentModel.fromLocal(Map<String, dynamic> map) {
    return FileDocumentModel(
      messageId: map['message_id'],
      serverUrl: map['server_url'],
      localUrl: map['local_url'],
      fileName: map['file_name'],
      fileSize: map['file_size'],
      fileType: map['file_type'],
      fileDownloadState: map['file_download_state']
    );
  }

  FileDocumentModel copyWith({
    String? fileName,
    String? fileType,
    String? fileSize,
    String? messageId,
    String? serverUrl,
    String? localUrl,
    int? fileDownloadState,
  }) {
    return FileDocumentModel(
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      fileSize: fileSize ?? this.fileSize,
      messageId: messageId ?? this.messageId,
      serverUrl: serverUrl ?? this.serverUrl,
      localUrl: localUrl ?? this.localUrl,
      fileDownloadState: fileDownloadState ?? this.fileDownloadState
    );
  }
}
