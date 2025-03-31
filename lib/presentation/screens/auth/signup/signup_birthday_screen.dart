import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/presentation/components/auth/signup/signup_button.dart';
import 'package:social_network/presentation/components/auth/signup/signup_date_picker.dart';
import 'package:social_network/presentation/screens/auth/signup/signup_controller.dart';
import 'package:social_network/presentation/screens/auth/signup/signup_gender_screen.dart';

class SignupBirthdayScreen extends StatefulWidget {
  final String fullName;
  const SignupBirthdayScreen({super.key, required this.fullName});

  @override
  State<SignupBirthdayScreen> createState() => _SignupBirthdayScreen();
}

class _SignupBirthdayScreen extends State<SignupBirthdayScreen> {
  late TextEditingController birthdayController;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    birthdayController = TextEditingController();
  }

  @override
  void dispose() {
    birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your birthday")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 10),
            Consumer<SignupController>(
              builder: (context, signupController, child) {
                return SignupDatePicker(
                  controller: birthdayController,
                  labelText: "Birthday",
                  errorMessage: signupController.errorMessage,
                  onDateSelected: (DateTime date) {
                    selectedDate = date;
                  },
                );
              },
            ),
            SizedBox(height: 10),
            Consumer<SignupController>(
              builder: (context, signpController, child) {
                return SignupButton(
                  color: Colors.blueAccent,
                  text: "Next",
                  onPressed: () {
                    if (signpController.validateField(
                      birthdayController.text.trim(),
                      "Please select your birthday",
                    )) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => SignupGenderScreen(
                                fullName: widget.fullName,
                                birthday: selectedDate ?? DateTime.now(),
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
