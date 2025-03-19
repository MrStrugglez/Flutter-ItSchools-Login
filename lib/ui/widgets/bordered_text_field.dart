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
      style: const TextStyle(color: Color(0xFF393939), fontSize: 13),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Color(0xFF755DC1), fontSize: 15),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: Color(0xFF837E93)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: Color(0xFF9F7BFF)),
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
