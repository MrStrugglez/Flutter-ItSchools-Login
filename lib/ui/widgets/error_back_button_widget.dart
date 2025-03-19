import 'package:flutter/material.dart';

class ErrorBackButton extends StatelessWidget {
  const ErrorBackButton({super.key});

  final buttonText = "Back";

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _navigateBack(context),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          Theme.of(context).colorScheme.error,
        ),
        minimumSize: WidgetStateProperty.all(Size(double.infinity, 50)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      child: Text(buttonText),
    );
  }

  void _navigateBack(BuildContext context) async {
    Navigator.pop(context);
  }
}
