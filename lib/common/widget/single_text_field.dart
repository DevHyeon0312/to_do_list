import 'package:flutter/material.dart';

class SingleTextField extends StatelessWidget {
  const SingleTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.backgroundColor,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        ),
        style: const TextStyle(color: Colors.black),
        maxLines: 1,
      ),
    );
  }
}
