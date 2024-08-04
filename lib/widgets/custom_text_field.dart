import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final bool enabled;
  final TextEditingController controller;
  final bool obscureText;
  final IconData data;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.enabled,
    required this.controller,
    required this.obscureText,
    required this.data,
    required this.hintText,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.controller,
        obscureText: widget.obscureText,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            widget.data,
            color: errorText != null ? Colors.red : Colors.cyan,
          ),
          hintText: errorText ?? widget.hintText,
          hintStyle: TextStyle(
            color: errorText != null ? Colors.red : Colors.grey,
          ),
          focusColor: Theme.of(context).primaryColor,
          errorText: null, // Prevent the default error text behavior
        ),
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              errorText = 'Please enter ${widget.hintText}.';
            });
            return null;
          } else {
            setState(() {
              errorText = null;
            });
          }
          return null;
        },
      ),
    );
  }
}
