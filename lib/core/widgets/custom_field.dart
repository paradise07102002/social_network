import 'package:flutter/material.dart';

class CustomField extends StatefulWidget {
  final String? lable;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? errorText;
  final int? maxLength;

  const CustomField({
    super.key,
    this.lable,
    this.icon,
    required this.isPassword,
    this.controller,
    this.errorText,
    this.maxLength,
  });

  @override
  State<CustomField> createState() => _CustomField();
}

class _CustomField extends State<CustomField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
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
