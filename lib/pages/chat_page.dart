import 'package:chatkro/components/chat_bubbles.dart';
import 'package:chatkro/components/my_textfield.dart';
import 'package:chatkro/services/auth/auth_service.dart';
import 'package:chatkro/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chatpage extends StatefulWidget {
  final String recieveremail;
  final String receiverid;
  chatpage({
    super.key,
    required this.recieveremail,
    required this.receiverid,
  });

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  final TextEditingController _messagecontroller = TextEditingController();

  final ChatService _chatService = ChatService();

  final AuthService _authservice = AuthService();

  FocusNode myfocusnode = FocusNode();
  @override
  void initState() {
    super.initState();

    myfocusnode.addListener(() {
      if (myfocusnode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrolldown());
      }
    });
    //Future.delayed(const Duration(milliseconds: 500), () => scrolldown());
  }

  @override
  void dispose() {
    myfocusnode.dispose();
    _messagecontroller.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  void scrolldown() {
    _scrollController.animateTo((_scrollController.position.maxScrollExtent),
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void sendmessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      await _chatService.sendmessage(
          widget.receiverid, _messagecontroller.text);

      _messagecontroller.clear();
    }
    scrolldown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.recieveremail),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildmessagelist(),
          ),
          _builuserinput(),
        ],
      ),
    );
  }

  Widget _buildmessagelist() {
    String senderid = _authservice.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getmessages(widget.receiverid, senderid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildmessageitem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildmessageitem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool iscurrentuser = data['senderid'] == _authservice.getCurrentUser()!.uid;

    var alignment =
        iscurrentuser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            iscurrentuser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          chatbubble(
            message: data["message"],
            iscurrentuser: iscurrentuser,
            messageid: doc.id,
            userid: data["senderid"],
          )
        ],
      ),
    );
  }

  Widget _builuserinput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 58.0),
      child: Row(
        children: [
          Expanded(
            child: mytextfield(
              controller: _messagecontroller,
              hinttext: "type a message",
              obsecuretext: false,
              focusNode: myfocusnode,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.greenAccent,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendmessage,
              icon: const Icon(
                Icons.arrow_upward_outlined,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
