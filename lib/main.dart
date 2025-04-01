import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/presentation/screens/auth/login/login_controller.dart';
import 'package:social_network/presentation/screens/auth/signup/signup_controller.dart';
import 'package:social_network/presentation/screens/splash/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupController()),
        ChangeNotifierProvider(create: (_) => LoginController())
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}