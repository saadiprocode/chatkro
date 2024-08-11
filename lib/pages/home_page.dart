import 'package:chatkro/components/my_drawer.dart';
import 'package:chatkro/components/user_tile.dart';
import 'package:chatkro/pages/chat_page.dart';
import 'package:chatkro/services/auth/auth_service.dart';
import 'package:chatkro/services/chat/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class homepage extends StatelessWidget {
  homepage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authservice = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("HOME"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      drawer: const mydrawer(),
      body: _builduserList(),
    );
  }

  Widget _builduserList() {
    return StreamBuilder(
      stream: _chatService.getusersstream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("loading");
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _builduserlistitem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _builduserlistitem(
      Map<String, dynamic> userdata, BuildContext context) {
    if (userdata["email"] != _authservice.getCurrentUser()!.email) {
      return usertile(
        text: userdata['email'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => chatpage(
                recieveremail: userdata["email"],
                receiverid: userdata["uid"],
              ),
            ),
          );
        },
      );
    } else
      return Container();
  }
}
