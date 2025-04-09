import 'dart:math';


String convertSizeToString(int bytes, {int decimals = 1}) {
  if (bytes <= 0) return "0 B";

  const List<String> units = ['B', 'KB', 'MB', 'GB', 'TB'];
  int unitIndex = (log(bytes) / log(1024)).floor();
  double convertedSize = bytes / pow(1024, unitIndex);

  return '${convertedSize.toStringAsFixed(decimals)} ${units[unitIndex]}';
}