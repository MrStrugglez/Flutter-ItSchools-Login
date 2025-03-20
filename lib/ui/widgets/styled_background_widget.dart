import 'package:flutter/material.dart';

class StyledBackgroundWidget extends StatefulWidget {
  final Widget child;
  final String logoPath;
  final double rotationAngle;
  final IconData icon;
  final Color drapeColor;

  const StyledBackgroundWidget({
    super.key,
    required this.child,
    required this.logoPath,
    required this.icon,
    this.rotationAngle = 0,
    required this.drapeColor,
  });

  @override
  StyledBackgroundWidgetState createState() => StyledBackgroundWidgetState();
}

class StyledBackgroundWidgetState extends State<StyledBackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackgroundIcon(),
        _buildBrackgroundDrape(),
        _buildIconFrame(),
        _buildLogo(),
        widget.child,
      ],
    );
  }

  Widget _buildBackgroundIcon() {
    return Center(
      child: Transform.rotate(
        angle: widget.rotationAngle,
        child: Icon(widget.icon, size: 350, color: Colors.black.withAlpha(50)),
      ),
    );
  }

  Widget _buildBrackgroundDrape() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 180),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0.7, 1.0],
            colors: [widget.drapeColor, widget.drapeColor.withAlpha(0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(300),
            topRight: Radius.circular(300),
          ),
        ),
      ),
    );
  }

  Widget _buildIconFrame() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 120),
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(top: 145),
      child: Center(child: Image.asset(widget.logoPath, width: 80, height: 80)),
    );
  }
}
