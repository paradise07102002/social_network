import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingDialog extends StatelessWidget {
  final String? content;
  final Color? backgroundColor;
  final Color? boderColor;
  final Color? textCorlor;

  const CustomLoadingDialog({
    super.key,
    this.content,
    this.backgroundColor,
    this.boderColor,
    this.textCorlor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 240,
        height: 240,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: boderColor ?? Colors.white, width: 3),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpinKitFadingCircle(color: Colors.blue),
              SizedBox(height: 16),
              Text(
                content ?? "is loading...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textCorlor ?? Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
