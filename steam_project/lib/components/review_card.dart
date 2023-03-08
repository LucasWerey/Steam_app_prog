import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String username;
  final String text;

  ReviewCard({required this.username, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context)
          .size
          .width, // élargir sur toute la largeur de l'écran
      color: Color(
          0xFF1E262C), // changer la couleur d'arrière-plan en utilisant la couleur hexadécimale
      child: Card(
        color: Color(0xFF1E262C),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(text,
                  style: TextStyle(
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
