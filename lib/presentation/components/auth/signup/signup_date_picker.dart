
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignupDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? errorMessage;
  final ValueChanged<DateTime>? onDateSelected;

  const SignupDatePicker({
    super.key,
    required this.controller,
    required this.labelText,
    this.errorMessage,
    this.onDateSelected,
  });

  @override
  State<SignupDatePicker> createState() => _SignupDatePicker();
}

class _SignupDatePicker extends State<SignupDatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isNotEmpty) {
      try {
        selectedDate = DateFormat('dd/MM/yyyy').parse(widget.controller.text);
      } catch (_) {
        selectedDate = DateTime.now();
      }
    } else {
      selectedDate = DateTime.now();
    }
  }

  void _showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            height: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: selectedDate,
                      minimumDate: DateTime(1900),
                      maximumDate: DateTime.now(),
                      onDateTimeChanged: (DateTime newDate) {
                        selectedDate = newDate;
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.controller.text = DateFormat(
                          'dd/MM/yyyy',
                        ).format(selectedDate!);
                        widget.onDateSelected?.call(selectedDate!);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Confirm",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(),
        errorText: widget.errorMessage,
      ),
      onTap: () => _showDatePicker(context),
    );
  }
}
