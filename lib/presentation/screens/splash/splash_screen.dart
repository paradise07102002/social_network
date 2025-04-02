import 'package:flutter/material.dart';
import 'package:social_network/data/repositories/auth_repository.dart';
import 'package:social_network/presentation/components/post/post_list.dart';
import 'package:social_network/presentation/screens/main_screen.dart';
import 'package:social_network/presentation/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  double _opacity = 0.8;
  double _scale = 0.8;

  final AuthRepository _authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final isLoggedIn = await _authRepository.refreshToken();

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isLoggedIn ? MainScreen() : WelcomeScreen(),
      ),
    );
  }

  void _startAnimation() {
    Future.delayed(Duration(microseconds: 500), () {
      if (!mounted) return;
      setState(() {
        _opacity = 1.0;
        _scale = 1.2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 1),
          child: AnimatedScale(
            scale: _scale,
            duration: Duration(seconds: 1),
            curve: Curves.easeOut,
            child: Image.asset(
              'assets/images/logo_connectify.png',
              width: size.width * 0.7,
            ),
          ),
        ),
      ),
    );
  }
}
