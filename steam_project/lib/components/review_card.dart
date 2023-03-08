import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String username;
  final String text;

  const ReviewCard({super.key, required this.username, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context)
          .size
          .width, // élargir sur toute la largeur de l'écran
      color: const Color(
          0xFF1E262C), // changer la couleur d'arrière-plan en utilisant la couleur hexadécimale
      child: Card(
        color: const Color(0xFF1E262C),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(text,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
