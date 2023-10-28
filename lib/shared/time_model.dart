import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeModel {
  Timestamp? timestamp;
  TimeModel(this.timestamp);

  String? date() {
    if (timestamp == null) {
      return null;
    } else {
      return '${timestamp!.toDate().day.toString().padLeft(2, '0')}/${timestamp!.toDate().month.toString().padLeft(2, '0')}/${timestamp!.toDate().year.toString()}';
    }
  }

  String hour() {
    return '${timestamp!.toDate().hour.toString().padLeft(2, '0')}:${timestamp!.toDate().minute.toString().padLeft(2, '0')}';
  }

  String monthString() => DateFormat("MMMM").format(timestamp!.toDate());
}
