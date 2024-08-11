import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Print debug message
    print("SplashScreen is being built");

    // Navigate to AuthGate after splash screen
    Future.delayed(Duration(seconds: 3), () {
      print("Navigating to AuthGate");
      Navigator.of(context).pushReplacementNamed('/auth');
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Adjust the size of the image
            Container(
              width: 150, // Set desired width
              height: 150, // Set desired height
              child: Image.asset('assets/images/logo.png',
                  fit: BoxFit.contain), // Adjust fit as needed
            ),
            SizedBox(height: 20), // Space between image and text
            Text(
              'ChatKro',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Customize text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
