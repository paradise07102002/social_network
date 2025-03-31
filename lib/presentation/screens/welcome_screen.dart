import 'package:flutter/material.dart';
import 'package:social_network/core/widgets/custom_button.dart';
import 'package:social_network/presentation/screens/auth/signup/signup_fullname_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_connectify.png',
              width: size.width * 0.8,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              'The Social Network for You – Connect, Discover, Inspire',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            SizedBox(height: 40),
            CustomButton(
              backgroundColor: Colors.blueAccent,
              borderColor: Colors.blueAccent,
              textColor: Colors.white,
              content: 'Signup',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupFullnameScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              backgroundColor: Colors.white,
              borderColor: Colors.blueAccent,
              textColor: Colors.blueAccent,
              content: 'Login',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
