import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/ui/widgets/error_back_button_widget.dart';
import 'package:flutter_itschools_login/ui/widgets/styled_background_widget.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  // Constants
  final logoPath = "assets/images/spinning_logo.png";
  final message = "Failed to login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: StyledBackgroundWidget(
            logoPath: logoPath,
            icon: Icons.add,
            drapeColor: Theme.of(context).colorScheme.error,
            // Rotating the plus icon 45 degress so that it looks like an X on the error screen.
            rotationAngle: 45 * 3.14159 / 180,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 400),
                  _buildMessage(),
                  const SizedBox(height: 190),
                  ErrorBackButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage() {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
