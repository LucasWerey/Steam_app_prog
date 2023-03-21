// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steam_project/model/game.dart';
import 'package:steam_project/resources/resources.dart';
import 'package:steam_project/services/api_service.dart';
import 'package:steam_project/components/slider_details.dart';
import 'package:steam_project/utils/showSnackBar.dart';

import '../components/buttons/svg_button.dart';
import '../components/details_game_card.dart';

class ProductPage extends StatefulWidget {
  final String appid;

  const ProductPage({Key? key, required this.appid}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<Game> _gameFuture;
  int? reviewScore;
  Game? game;
  bool isLiked = false;
  bool isFavorited = false;
  final String _language = "english";

  Future<void> checkIfLiked() async {
    final userDocSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('likes')
        .doc(widget.appid)
        .get();
    if (userDocSnapshot.exists) {
      setState(() {
        isLiked = true;
      });
    }
  }

  Future<void> checkIfFavorited() async {
    final userDocSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('wishlist')
        .doc(widget.appid)
        .get();
    if (userDocSnapshot.exists) {
      setState(() {
        isFavorited = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _gameFuture = fetchGame(int.parse(widget.appid), _language);
    checkIfLiked();
    checkIfFavorited();
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
            onPressed: () async {
              final userDocRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('likes')
                  .doc(widget.appid);
              final userDocSnapshot = await userDocRef.get();
              if (userDocSnapshot.exists) {
                try {
                  await userDocRef.delete();
                  showSnackBar(context, 'Jeu retiré des likes avec succès');
                } catch (e) {
                  showSnackBar(context, 'Erreur pendant la suppression du jeu');
                }
                setState(() {
                  isLiked = false;
                });
              } else {
                if (game != null) {
                  try {
                    await userDocRef.set({
                      'name': game!.name,
                      'headerImage': game!.headerImage,
                      'background': game!.background,
                      'developers': game!.developers,
                      'free': game!.isFree,
                      'price': game!.isFree ? 0 : game!.final_formatted,
                    });
                    showSnackBar(context, 'Jeu ajouté aux likes avec succès');
                  } catch (e) {
                    showSnackBar(context, "Erreur pendant l'ajout du jeu");
                  }
                  setState(() {
                    isLiked = true;
                  });
                }
              }
            },
            svgPath: isLiked ? VectorialImages.likeFull : VectorialImages.like,
          ),
          const SizedBox(width: 10),
          SvgClickableComponent(
            onPressed: () async {
              final userDocRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('wishlist')
                  .doc(widget.appid);
              final userDocSnapshot = await userDocRef.get();
              if (userDocSnapshot.exists) {
                try {
                  await userDocRef.delete();
                  showSnackBar(context,
                      'Jeu retiré de la liste de souhaits avec succès');
                } catch (e) {
                  showSnackBar(context, 'Erreur pendant la suppression du jeu');
                }
                setState(() {
                  isFavorited = false;
                });
              } else {
                if (game != null) {
                  try {
                    await userDocRef.set({
                      'name': game!.name,
                      'headerImage': game!.headerImage,
                      'background': game!.background,
                      'developers': game!.developers,
                      'free': game!.isFree,
                      'price': game!.isFree ? 0 : game!.final_formatted,
                    });
                    showSnackBar(context,
                        'Jeu ajouté à la liste de souhaits avec succès');
                  } catch (e) {
                    showSnackBar(context, "Erreur pendant l'ajout du jeu");
                  }
                  setState(() {
                    isFavorited = true;
                  });
                }
              }
            },
            svgPath: isFavorited
                ? VectorialImages.whishlistFull
                : VectorialImages.whishlist,
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: FutureBuilder<Game>(
        future: _gameFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            game = snapshot.data!;
            return FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchGameReview(int.parse(widget.appid), 'french'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final reviews = snapshot.data!;
                  reviewScore = reviews[0]['review_score'];
                  return Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(game!.backgroundRaw),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: GameDetailsSlider(
                                appid: widget.appid,
                                description: game!.description,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DetailsCard(
                        imagePath: game!.background,
                        gameName: game!.name,
                        publisherName: game!.developers.join(', '),
                        headerImage: game!.headerImage,
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
