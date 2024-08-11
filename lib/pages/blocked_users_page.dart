import 'dart:html';

import 'package:chatkro/components/user_tile.dart';
import 'package:chatkro/services/auth/auth_service.dart';
import 'package:chatkro/services/chat/chat_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class blockeduserpage extends StatelessWidget {
  blockeduserpage({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();
  void _unblockusers(BuildContext context, String userid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Unblock users"),
        content: const Text("are you sure want to  unblock this user?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              chatService.unblockuser(userid);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("user unblocked"),
              ));
            },
            child: const Text("Unblock"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userid = authService.getCurrentUser()!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text("blocked users"),
        actions: [],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatService.getblockedusersstream(userid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error while loading..."));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final blockedusers = snapshot.data ?? [];
          if (blockedusers.isEmpty) {
            return const Center(
              child: Text('np blocked users'),
            );
          }
          return ListView.builder(
            itemCount: blockedusers.length,
            itemBuilder: (context, index) {
              final user = blockedusers[index];
              return usertile(
                text: user["email"],
                onTap: () => _unblockusers(context, user['uid']),
              );
            },
          );
        },
      ),
    );
  }
}
