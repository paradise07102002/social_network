import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final String content;
  final VoidCallback? onPressed;
  const CustomButton({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.content,
    required this.onPressed,
  });

  @override
  State<CustomButton> createState() => _CustomButton();
}

class _CustomButton extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: widget.borderColor, width: 2),
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.content,
          style: TextStyle(color: widget.textColor, fontSize: 18),
        ),
      ),
    );
  }
}
