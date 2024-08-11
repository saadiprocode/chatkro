import 'package:chatkro/services/auth/auth_service.dart';
import 'package:chatkro/components/my_button.dart';
import 'package:chatkro/components/my_textfield.dart';
import 'package:flutter/material.dart';

class registerpage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();
  final TextEditingController _confirmpwcontroller = TextEditingController();
  final void Function()? onTap;

  void register(BuildContext context) {
    final _auth = AuthService();
    if (_pwcontroller.text == _confirmpwcontroller.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailcontroller.text,
          _pwcontroller.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("passwords dont match"),
        ),
      );
    }
  }

  registerpage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.messenger_outline_sharp,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 50),
          Text(
            'ENTER ACCOUNT DETAILS',
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 26),
          ),
          const SizedBox(height: 50),
          mytextfield(
            hinttext: "Enter your email",
            obsecuretext: false,
            controller: _emailcontroller,
          ),
          const SizedBox(height: 25),
          mytextfield(
            hinttext: "Enter your password",
            obsecuretext: true,
            controller: _pwcontroller,
          ),
          const SizedBox(height: 20),
          mytextfield(
            hinttext: "Confirm password",
            obsecuretext: true,
            controller: _confirmpwcontroller,
          ),
          const SizedBox(height: 20),
          mybutton(
            text: "Register",
            onTap: () => register(context),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already a member? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login now ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
