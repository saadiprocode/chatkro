import 'package:flutter/material.dart';
import 'package:chatkro/modules/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getusersstream() {
    return _firestore.collection("Users").snapshots().map((Snapshot) {
      return Snapshot.docs.map((doc) {
        final User = doc.data();
        return User;
      }).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getUsersStreamExcludingBlocked() {
    final currentUser = _auth.currentUser;

    return _firestore
        .collection('users')
        .snapshots()
        .asyncMap((usersSnapshot) async {
      // Get the list of blocked users for the current user
      final blockedUsersSnapshot = await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('blockedusers')
          .get();

      final blockedUserIds =
          blockedUsersSnapshot.docs.map((doc) => doc.id).toSet();

      // Log blocked user IDs
      print("Blocked User IDs: $blockedUserIds");

      // Filter users excluding the current user and blocked users
      final nonBlockedUsers = usersSnapshot.docs
          .where((userDoc) =>
              userDoc.id != currentUser.uid &&
              !blockedUserIds.contains(userDoc.id))
          .map((userDoc) => {
                'uid': userDoc.id,
                'email': userDoc['email'],
                // Add other user fields you need here
              })
          .toList();

      // Log non-blocked users
      print("Non-blocked Users: $nonBlockedUsers");

      return nonBlockedUsers;
    });
  }

  Future<void> sendmessage(String receiverid, message) async {
    final currentuserid = FirebaseAuth.instance.currentUser!.uid;
    final currentuseremail = FirebaseAuth.instance.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newmessage = Message(
      senderemail: currentuseremail,
      senderid: currentuserid,
      recieverid: receiverid,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentuserid, receiverid];
    ids.sort();
    String chatroomid = ids.join('_');
    await _firestore
        .collection("chat_rooms")
        .doc(chatroomid)
        .collection("messages")
        .add(newmessage.toMap());
  }

  Stream<QuerySnapshot> getmessages(String userid, otheruserid) {
    List<String> ids = [userid, otheruserid];
    ids.sort();
    String chatroomid = ids.join('_');
    return _firestore
        .collection("chat_rooms")
        .doc(chatroomid)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Future<void> reportUser(String messageid, String userid) async {
    final currentuserid = _auth.currentUser;
    final report = {
      'reportedby': currentuserid,
      'messageid': messageid,
      'messageownerid': userid,
      'timestamp': FieldValue.serverTimestamp(),
    };
    await _firestore.collection('reports').add(report);
  }

  Future<void> blockuser(String userid) async {
    final currentuser = _auth.currentUser;
    await _firestore
        .collection('users')
        .doc(currentuser!.uid)
        .collection('blockedusers')
        .doc(userid)
        .set({});
    notifyListeners();
  }

  Future<void> unblockuser(String blockuserid) async {
    final currentuser = _auth.currentUser;
    await _firestore
        .collection('users')
        .doc(currentuser!.uid)
        .collection('blockedusers')
        .doc(blockuserid)
        .delete();
  }

  Stream<List<Map<String, dynamic>>> getblockedusersstream(String userid) {
    return _firestore
        .collection('users')
        .doc(userid)
        .collection('blockedusers')
        .snapshots()
        .asyncMap((snapshot) async {
      final blockedusersids = snapshot.docs.map((doc) => doc.id).toList();

      final userdocs = await Future.wait(
        blockedusersids
            .map((id) => _firestore.collection('users').doc(id).get()),
      );

      return userdocs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }
}
