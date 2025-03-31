import 'package:flutter/material.dart';
import 'package:social_network/presentation/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  double _opacity = 0.8;
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(Duration(microseconds: 500), () {
      if (!mounted) return;
      setState(() {
        _opacity = 1.0;
        _scale = 1.2;
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
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
