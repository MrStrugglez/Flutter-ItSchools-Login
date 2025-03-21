import 'package:flutter/material.dart';

class BorderedTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final bool obscureText;

  const BorderedTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.focusNode,
    this.nextFocusNode,
    this.obscureText = false,
  });

  @override
  State<BorderedTextField> createState() => _BorderedTextFieldState();
}

class _BorderedTextFieldState extends State<BorderedTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      textAlign: TextAlign.center,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 13),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 15,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      onSubmitted: (value) {
        if (widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
    );
  }
}
