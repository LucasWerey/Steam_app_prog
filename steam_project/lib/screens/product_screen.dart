import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:steam_project/model/game.dart';
import 'package:steam_project/resources/resources.dart';
import 'package:steam_project/services/api_service.dart';

class ProductPage extends StatefulWidget {
  final String appid;

  const ProductPage({Key? key, required this.appid}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<Game> _gameFuture;
  int _currentTab = 0;

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
          IconButton(
            icon: SvgPicture.asset(VectorialImages.like),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(VectorialImages.whishlist),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<Game>(
        future: _gameFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final game = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(game.backgroundRaw),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _currentTab = 0;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _currentTab == 0
                                      ? const Color(0xFF636AF6)
                                      : const Color(0xFF1a2025),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(3.54),
                                    ),
                                  ),
                                  side: const BorderSide(
                                      color: Color(0xFF636AF6)),
                                ),
                                child: const Text(
                                  'DESCRIPTION',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _currentTab = 1;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _currentTab == 1
                                      ? const Color(0xFF636AF6)
                                      : const Color(0xFF1a2025),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(3.54),
                                    ),
                                  ),
                                  side: const BorderSide(
                                      color: Color(0xFF636AF6)),
                                ),
                                child: const Text(
                                  'AVIS',
                                  style:  TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _currentTab == 0
                            ? Center(
                                child: Text(
                                  game.shortDescription,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const Center(
                                child: Text(
                                  'Avis sur le jeu',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                )
              ],
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
