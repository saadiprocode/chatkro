import 'package:chatkro/services/chat/chat_service.dart';
import 'package:chatkro/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class chatbubble extends StatelessWidget {
  final String message;
  final bool iscurrentuser;
  final String messageid;
  final String userid;

  const chatbubble({
    super.key,
    required this.iscurrentuser,
    required this.message,
    required this.messageid,
    required this.userid,
  });
  void _showoptions(BuildContext context, String messageid, String userid) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.flag),
                title: const Text('Report'),
                onTap: () {
                  Navigator.pop(context);
                  _reportmessage(context, messageid, userid);
                },
              ),
              ListTile(
                leading: const Icon(Icons.block),
                title: const Text('Blocked'),
                onTap: () {
                  Navigator.pop(context);
                  _blockuser(context, userid);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _reportmessage(BuildContext context, String messageid, String userid) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Report message"),
              content:
                  const Text("Are you sure you want to report this message? "),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    ChatService().reportUser(messageid, userid);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Message Reported!")));
                  },
                  child: const Text('Report'),
                ),
              ],
            ));
  }

  void _blockuser(BuildContext context, String userid) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Block user"),
              content: const Text("Are you sure you want to block this user? "),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    ChatService().blockuser(userid);
                    Navigator.pop(context);
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("User blocked!")));
                  },
                  child: const Text('Block'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    bool isdarkmode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return GestureDetector(
      onLongPress: () {
        if (!iscurrentuser) {
          _showoptions(context, messageid, userid);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: iscurrentuser
              ? (isdarkmode
                  ? Colors.greenAccent.shade700
                  : Colors.greenAccent.shade400)
              : (isdarkmode ? Colors.grey.shade800 : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
        child: Text(
          message,
          style: TextStyle(
              color: iscurrentuser
                  ? Colors.white
                  : (isdarkmode ? Colors.white : Colors.black)),
        ),
      ),
    );
  }
}
