import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/resources.dart';

class LoginTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String hintText;
  final bool showError;

  const LoginTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    required this.obscureText,
    required this.showError,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  Color _borderColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.52),
          border: Border.all(
            color: widget.showError ? Colors.red : _borderColor,
          ),
        ),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              textAlign: TextAlign.center,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Proxima',
                fontSize: 15.23,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: const Color.fromARGB(255, 30, 38, 44),
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Proxima',
                  fontSize: 15.23,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _borderColor = Colors.transparent;
                });
              },
            ),
            if (widget.showError)
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(VectorialImages.warning)),
          ],
        ),
      ),
    );
  }
}
