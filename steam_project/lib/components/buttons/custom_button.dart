import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final bool filled;
  final String text;
  final String page;

  const MyButton({
    super.key,
    required this.filled,
    required this.text,
    required this.page,
  });

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
          // Within the `FirstScreen` widget
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/$page');
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 0, color: Colors.transparent),
          ),
          child: Center(
            child: Text(text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.24,
                    fontFamily: 'Proxima')),
          ),
        ),
      ),
    ));
  }
}
