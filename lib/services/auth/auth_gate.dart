import 'package:chatkro/services/auth/login_or_register.dart';
import 'package:chatkro/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class authgate extends StatelessWidget {
  const authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return homepage();
          } else {
            return loginorregister();
          }
        },
      ),
    );
  }
}
