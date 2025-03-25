
import 'package:cloud_firestore/cloud_firestore.dart';

class TimestampUtils{
  static Timestamp stringToTimestamp(String value) {
    return Timestamp.fromDate(DateTime.parse(value));
  }

  static String timestampToString(Timestamp value) {
    return value.toDate().toIso8601String();
  }

  static Timestamp getMinimumTimestamp() {
    return Timestamp.fromMillisecondsSinceEpoch(0);
  }
}