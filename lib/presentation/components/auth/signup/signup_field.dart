import 'package:flutter/material.dart';

class SignupField extends StatefulWidget {
  final String lable;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? errorText;
  final int maxLength;

  const SignupField({
    super.key,
    required this.lable,
    required this.icon,
    this.isPassword = false,
    required this.controller,
    this.errorText,
    required this.maxLength
  });

  @override
  State<SignupField> createState() => _SignupField();
}

class _SignupField extends State<SignupField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        labelText: widget.lable,
        prefixIcon: Icon(widget.icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        errorText: widget.errorText,
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                )
                : null,
      ),
    );
  }
}
