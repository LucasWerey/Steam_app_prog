// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:steam_project/components/searchbar.dart';
import 'package:steam_project/model/game.dart';
import 'package:steam_project/screens/search_screen.dart';
import '../components/game_card.dart';
import '../components/topbar.dart';
import '../resources/resources.dart';
import '../services/api_service.dart';
import '../services/firebase_auth_methods.dart';
import '../components/hero.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  List<int> appIds = [];

  void signOut() {
    FirebaseAuthMethods(FirebaseAuth.instance).signOut(context);
  }

  Future<void> _searchGamesPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchPage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchAppIds().then((ids) {
      setState(() {
        appIds = ids;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.backgroundEmpty),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              TopBar(onSignOutPressed: signOut),
              const SizedBox(height: 12),
              Search_Bar(
                controller: searchController,
                hintText: 'Rechercher un jeu...',
                  onChanged: (query) {
                  if (query.isNotEmpty) {
                    _searchGamesPage();
                  }
                },
              ),
              const SizedBox(height: 10),
              const HeroComponent(
                title: "Hogwarts Legacy : L'Héritage de Poudlard",
                description:
                    "Hogwarts Legacy est un RPG d'action-aventure immersif en monde ouvert.",
                backgroundImageUrl:
                    'https:\/\/cdn.akamai.steamstatic.com\/steam\/apps\/990080\/page_bg_generated_v6b.jpg?t=1676412613',
                imagePath: Images.hero,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Les jeux les plus joués',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Proxima',
                      decoration: TextDecoration.underline,
                      decorationThickness: 4,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: appIds.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<Game>(
                      future: fetchGame(appIds[index]),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final game = snapshot.data!;
                          return GameCard(
                            appId: game.steam_appid,
                            gameName: game.name,
                            gameImage: game.headerImage,
                            backgroundImage: game.background,
                            free: game.isFree.toString(),
                            gameEditor: game.developers,
                          );
                        } else if (snapshot.hasError) {
                          return const Text("Echec chargement du jeu");
                        }
                        return const CircularProgressIndicator();
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
