import 'dart:math';


String convertSizeToString(int bytes, {int decimals = 1}) {
  if (bytes <= 0) return "0 B";

  const List<String> units = ['B', 'KB', 'MB', 'GB', 'TB'];
  int unitIndex = (log(bytes) / log(1024)).floor();
  double convertedSize = bytes / pow(1024, unitIndex);

  return '${convertedSize.toStringAsFixed(decimals)} ${units[unitIndex]}';
}

String getFileExtensionFromContentType(String? contentType) {
  switch (contentType) {
    case 'application/pdf':
      return '.pdf';
    case 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet':
      return '.xlsx';
    case 'application/vnd.ms-excel':
      return '.xls';
    case 'image/jpeg':
      return '.jpg';
    case 'image/png':
      return '.png';
    case 'text/plain':
      return '.txt';
    case 'application/msword':
      return '.doc';
    case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
      return '.docx';
    default:
      return '.bin'; // fallback extension
  }
}