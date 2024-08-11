import 'package:chatkro/services/auth/auth_service.dart';
import 'package:chatkro/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:chatkro/components/my_textfield.dart';

class loginpage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();

  final void Function()? onTap;

  loginpage({super.key, required this.onTap});
  void login(BuildContext context) async {
    final authservice = AuthService();

    try {
      await authservice.signInWithEmailPassword(
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
  }

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
            'Welcome to Messenger',
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
          mybutton(
            text: "login",
            onTap: () => login(context),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New here? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Register now ",
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
