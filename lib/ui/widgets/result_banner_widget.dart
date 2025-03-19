import 'package:flutter/material.dart';

class ResultBannerWidget extends StatefulWidget {
  final String bannerPath;
  final IconData icon;
  final double rotationAngle;

  const ResultBannerWidget({
    super.key,
    required this.bannerPath,
    required this.icon,
    this.rotationAngle = 0,
  });

  @override
  State<ResultBannerWidget> createState() => _ResultBannerWidgetState();
}

class _ResultBannerWidgetState extends State<ResultBannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(widget.bannerPath),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Center(
            child: Transform.rotate(
              angle: widget.rotationAngle,
              child: Icon(widget.icon, size: 200, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
