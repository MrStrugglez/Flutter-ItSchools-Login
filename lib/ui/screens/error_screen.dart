import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/ui/widgets/error_back_button_widget.dart';
import 'package:flutter_itschools_login/ui/widgets/result_banner_widget.dart';

class ErrorScreen extends StatelessWidget {
  final bannerPath = "assets/images/error_banner.png";
  final message = "Failed to Login.";

  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ResultBannerWidget(
                bannerPath: bannerPath,
                icon: Icons.add_circle_outline_rounded,
                rotationAngle: 45 * 3.14159 / 180,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 100,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                  const SizedBox(height: 130),
                  ErrorBackButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
