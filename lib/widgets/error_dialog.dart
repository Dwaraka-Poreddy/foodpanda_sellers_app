import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String? message;
  const ErrorDialog({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message ?? "An error occurred!"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(backgroundColor: Colors.red),
          child: const Center(
              child: Text("OK", style: TextStyle(color: Colors.white))),
        )
      ],
    );
  }
}
