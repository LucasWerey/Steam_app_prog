import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String hintText;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: TextField(
            textAlign: TextAlign.center,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: const TextStyle(
                color: Colors.white, fontFamily: 'Proxima', fontSize: 15.23),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.52),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.52),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1.0),
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 30, 38, 44),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'Proxima',
                fontSize: 15.23,
              ),
            )));
  }
}
