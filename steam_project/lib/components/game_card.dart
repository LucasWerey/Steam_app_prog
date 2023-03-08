import 'package:flutter/material.dart';
import '../resources/resources.dart';
import '../screens/product_screen.dart';

class GameCard extends StatelessWidget {
  final String appId;
  final String gameName;
  final String backgroundImage;
  final String gameImage;
  final List gameEditor;
  final String free;

  const GameCard({
    required this.appId,
    required this.gameName,
    required this.backgroundImage,
    required this.gameEditor,
    required this.free,
    required this.gameImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            // ignore: unnecessary_null_comparison
            image: backgroundImage != null
                ? DecorationImage(
                    image: NetworkImage(backgroundImage),
                    fit: BoxFit.cover,
                  )
                : const DecorationImage(
                    image: AssetImage(Images.backgroundEmpty),
                    fit: BoxFit.cover,
                  ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Colors.transparent,
                ),
                child: Image.network(
                  gameImage,
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gameName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        gameEditor[0],
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        free,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 99, 106, 246),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 99, 106, 246),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(appid: appId),
                      ),
                    );
                  },
                  child: const Text(
                    'En savoir plus',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
