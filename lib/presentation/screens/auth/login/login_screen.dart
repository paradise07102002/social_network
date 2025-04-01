import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:social_network/core/widgets/custom_button.dart';
import 'package:social_network/core/widgets/custom_field.dart';
import 'package:social_network/core/widgets/custom_loading_diaglog.dart';
import 'package:social_network/presentation/screens/auth/login/login_controller.dart';
import 'package:social_network/presentation/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Consumer<LoginController>(
                builder: (context, loginController, child) {
                  return Column(
                    children: [
                      Image.asset(
                        'assets/images/logo_connectify.png',
                        width: size.width * 0.7,
                      ),
                      SizedBox(height: 15),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(color: Colors.black12)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15),
                            CustomField(
                              controller: _emailController,
                              lable: 'Email',
                              isPassword: false,
                              icon: Icons.email,
                              errorText: loginController.emailError,
                            ),
                            SizedBox(height: 15),
                            CustomField(
                              controller: _passwordController,
                              lable: 'Password',
                              isPassword: true,
                              icon: Icons.lock,
                              errorText: loginController.passwordError,
                            ),
                            SizedBox(height: 15),
                            CustomButton(
                              backgroundColor: Colors.blueAccent,
                              borderColor: Colors.white,
                              textColor: Colors.white,
                              content: 'Login',
                              onPressed: () async {
                                await loginController.login(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                  onSuccess: () {
                                    Fluttertoast.showToast(
                                      msg: "Login success",
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                    );
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  onError: (message) {
                                    Fluttertoast.showToast(
                                      msg: message,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.2),
                    ],
                  );
                },
              ),
              Consumer<LoginController>(
                builder: (context, loginController, child) {
                  if (loginController.isLoading) {
                    return Positioned.fill(
                      child: Container(
                        color: Colors.transparent,
                        child: Center(child: CustomLoadingDialog()),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
