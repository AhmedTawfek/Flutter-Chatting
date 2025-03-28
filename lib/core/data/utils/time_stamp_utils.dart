
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimestampUtils{
  static Timestamp stringToTimestamp(String value) {
    return Timestamp.fromDate(DateTime.parse(value));
  }

  static String timestampToString(Timestamp? value) {
    value ??= getMinimumTimestamp();
    return value.toDate().toIso8601String();
  }

  static Timestamp getMinimumTimestamp() {
    return Timestamp.fromMillisecondsSinceEpoch(0);
  }

  static String getTimeFromTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('h:mm a').format(dateTime);
  }
}