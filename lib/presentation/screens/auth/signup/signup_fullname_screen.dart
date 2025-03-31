import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/presentation/components/auth/signup/signup_button.dart';
import 'package:social_network/presentation/components/auth/signup/signup_field.dart';
import 'package:social_network/presentation/screens/auth/signup/signup_birthday_screen.dart';
import 'package:social_network/presentation/screens/auth/signup/signup_controller.dart';

class SignupFullnameScreen extends StatefulWidget {
  const SignupFullnameScreen({super.key});

  @override
  State<SignupFullnameScreen> createState() => _SignupFullnameScreen();
}

class _SignupFullnameScreen extends State<SignupFullnameScreen> {
  late TextEditingController fullNameController;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("What's your name")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 10),
            Consumer<SignupController>(
              builder: (context, signupController, child) {
                return SignupField(
                  lable: 'Enter your name',
                  icon: Icons.people,
                  controller: fullNameController,
                  errorText: signupController.errorMessage,
                  maxLength: 50,
                );
              },
            ),
            SizedBox(height: 10),

            Consumer<SignupController>(
              builder: (context, signupController, child) {
                return SignupButton(
                  color: Colors.blueAccent,
                  text: "Next",
                  onPressed: () {
                    if (signupController.validateField(
                      fullNameController.text.trim(),
                      'Please enter your name',
                    )) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => SignupBirthdayScreen(
                                fullName: fullNameController.text.trim(),
                              ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
