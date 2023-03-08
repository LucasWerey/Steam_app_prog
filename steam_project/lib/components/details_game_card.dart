import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    Key? key,
    required this.gameName,
    required this.publisherName,
    required this.imagePath,
    required this.headerImage,
  }) : super(key: key);

  final String gameName;
  final String publisherName;
  final String imagePath;
  final String headerImage;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.33,
      left: 20,
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  headerImage,
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    gameName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    publisherName,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
