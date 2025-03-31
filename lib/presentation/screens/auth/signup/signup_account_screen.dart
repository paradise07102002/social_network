import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/core/widgets/custom_loading_diaglog.dart';
import 'package:social_network/presentation/components/auth/signup/signup_button.dart';
import 'package:social_network/presentation/components/auth/signup/signup_field.dart';
import 'package:social_network/presentation/screens/auth/signup/signup_controller.dart';

class SignupAccountScreen extends StatefulWidget {
  final String fullName;
  final DateTime birthday;
  final int gender;

  const SignupAccountScreen({
    super.key,
    required this.fullName,
    required this.birthday,
    required this.gender,
  });

  @override
  State<SignupAccountScreen> createState() => _SignupAccountScreen();
}

class _SignupAccountScreen extends State<SignupAccountScreen> {
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _rePasswordController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create account")),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Consumer<SignupController>(
              builder: (context, signupController, child) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    SignupField(
                      lable: 'User name',
                      icon: Icons.people,
                      controller: _userNameController,
                      errorText: signupController.userNameError,
                      maxLength: 15,
                    ),
                    SizedBox(height: 10),
                    SignupField(
                      lable: 'Email',
                      icon: Icons.email,
                      controller: _emailController,
                      errorText: signupController.emailError,
                      maxLength: 254,
                    ),
                    SizedBox(height: 10),
                    SignupField(
                      lable: 'Password',
                      icon: Icons.lock,
                      controller: _passwordController,
                      errorText: signupController.passwordError,
                      isPassword: true,
                      maxLength: 64,
                    ),
                    SizedBox(height: 10),
                    SignupField(
                      lable: 'Confirm Password',
                      icon: Icons.lock,
                      controller: _rePasswordController,
                      errorText: signupController.rePasswordError,
                      isPassword: true,
                      maxLength: 64,
                    ),
                    SizedBox(height: 10),
                    SignupButton(
                      color: Colors.blueAccent,
                      text: "Signup",
                      onPressed: () async {
                        await signupController.signup(
                          userName: _userNameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          rePassword: _rePasswordController.text,
                          dateOfBirth: widget.birthday,
                          fullName: widget.fullName,
                          gender: widget.gender,
                          onError: () {},
                          onSuccess: () {},
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          Consumer<SignupController>(
            builder: (context, signupController, child) {
              if (signupController.isLoading) {
                return Center(child: CustomLoadingDialog(),);
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
