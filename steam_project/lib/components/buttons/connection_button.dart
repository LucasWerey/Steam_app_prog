import 'package:flutter/material.dart';

class ConnectionButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final bool filled;

  const ConnectionButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      required this.filled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Container(
              height: 46.89,
              margin: const EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.52),
                color: filled
                    ? const Color.fromARGB(255, 99, 106, 246)
                    : Colors.transparent,
                border: Border.all(
                  color: const Color.fromARGB(255, 99, 106, 246),
                  width: 2,
                ),
              ),
              child: OutlinedButton(
                onPressed: () => onPressed(),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(width: 0, color: Colors.transparent),
                ),
                child: Center(
                  child: Text(buttonText,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15.24,
                          fontFamily: 'Proxima')),
                ),
              ),
            )));
  }
}
