import 'package:flutter/material.dart';
import 'package:social_network/presentation/components/auth/signup/signup_button.dart';
import 'package:social_network/presentation/screens/auth/signup/signup_account_screen.dart';

class SignupGenderScreen extends StatefulWidget {
  final String fullName;
  final DateTime birthday;
  const SignupGenderScreen({
    super.key,
    required this.fullName,
    required this.birthday,
  });

  @override
  State<SignupGenderScreen> createState() => _SignupGenderScreen();
}

class _SignupGenderScreen extends State<SignupGenderScreen> {
  int? _selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your gender')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            RadioListTile<int>(
              title: Text("Male"),
              value: 1,
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            RadioListTile<int>(
              title: Text("Female"),
              value: 2,
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            RadioListTile<int>(
              title: Text("Other"),
              value: 3,
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            SizedBox(height: 20),
            SignupButton(
              color: Colors.blueAccent,
              disableColor: Colors.blueAccent.withOpacity(0.5),
              text: "Next",
              onPressed:
                  _selectedGender == null
                      ? null
                      : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SignupAccountScreen(
                                  fullName: widget.fullName,
                                  birthday: widget.birthday,
                                  gender: _selectedGender ?? 1,
                                ),
                          ),
                        );
                      },
            ),
          ],
        ),
      ),
    );
  }
}
