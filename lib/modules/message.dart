import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderid;
  final String senderemail;

  final String recieverid;

  final String message;

  final Timestamp timestamp;

  Message(
      {required this.message,
      required this.recieverid,
      required this.senderemail,
      required this.senderid,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderid': senderid,
      'senderemail': senderemail,
      'recieverid': recieverid,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
