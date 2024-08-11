import 'package:chatkro/pages/blocked_users_page.dart';
import 'package:chatkro/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("S E T T I N G S"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
        actions: [],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(25),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Darkmode",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    CupertinoSwitch(
                      value: Provider.of<ThemeProvider>(context, listen: false)
                          .isDarkMode,
                      onChanged: (value) =>
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme(),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(25),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "blockedusers",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => blockeduserpage(),
                          )),
                      icon: Icon(Icons.arrow_forward_rounded),
                      color: Theme.of(context).colorScheme.primary,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
