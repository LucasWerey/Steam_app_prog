import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:steam_project/model/game.dart';
import 'package:steam_project/resources/resources.dart';
import 'package:steam_project/services/api_service.dart';
import 'package:steam_project/components/slider_details.dart';

import '../components/buttons/svg_button.dart';
import '../components/details_game_card.dart';

class ProductPage extends StatefulWidget {
  final String appid;

  const ProductPage({Key? key, required this.appid}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<Game> _gameFuture;
  int _currentTab = 0;
  int? reviewScore;

  @override
  void initState() {
    super.initState();
    _gameFuture = fetchGame(int.parse(widget.appid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a2025),
      appBar: AppBar(
        title: const Text('Détails du jeu'),
        backgroundColor: const Color(0xFF1a2025),
        actions: <Widget>[
          SvgClickableComponent(
            onPressed: () {},
            svgPath: VectorialImages.like,
          ),
          const SizedBox(width: 10),
          SvgClickableComponent(
            onPressed: () {},
            svgPath: VectorialImages.whishlist,
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: FutureBuilder<Game>(
        future: _gameFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final game = snapshot.data!;
            return FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchGameReview(int.parse(widget.appid)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final reviews = snapshot.data!;
                  reviewScore = reviews[0]['review_score'].toDouble();
                  return Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(game.backgroundRaw),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: GameDetailsSlider(
                                appid: widget.appid,
                                description: game.shortDescription,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DetailsCard(
                        imagePath: game.background,
                        gameName: game.name,
                        publisherName: game.developers.join(', '),
                        headerImage: game.headerImage,
                        rating: reviewScore,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
