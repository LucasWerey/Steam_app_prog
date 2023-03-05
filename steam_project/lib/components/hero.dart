import 'package:flutter/material.dart';
import '../resources/resources.dart';

class CustomComponent extends StatelessWidget {
  final String title;
  final String description;
  final String backgroundImageUrl;
  final String imagePath;
  final VoidCallback onPressed;

  const CustomComponent({
    super.key,
    required this.title,
    required this.description,
    required this.backgroundImageUrl,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 185,
      width: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(backgroundImageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 25, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 200,
                    child: Text(
                      "Hogwarts Legacy : L'Héritage de Poudlard",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.79,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Proxima',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    width: 200,
                    child: Text(
                      "Hogwarts Legacy est un RPG d'action-aventure immersif en monde ouvert.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.74,
                        fontFamily: 'Proxima',
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(165, 35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color.fromARGB(255, 99, 106, 246),
                    ),
                    child: const Text(
                      'En savoir plus',
                      style: TextStyle(fontSize: 15, fontFamily: 'Proxima'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 12, right: 16),
            child: Image.asset(
              imagePath,
              height: 130,
              width: 102,
            ),
          ),
        ],
      ),
    );
  }
}
