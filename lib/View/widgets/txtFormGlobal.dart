import 'package:flutter/material.dart';

class TxtFormGlobal extends StatelessWidget {
  const TxtFormGlobal(
      {Key? key,
        required this.controller,
        required this.placeHolder,
        required this.textInputType,
        required this.obscure})
      : super(key: key);
  final TextEditingController controller;
  final String placeHolder;
  final TextInputType textInputType;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 7)
          ]),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscure,
        decoration: InputDecoration(
            hintText: placeHolder,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(8)),
      ),
    );
  }
}
