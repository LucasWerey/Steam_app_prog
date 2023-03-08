// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:steam_project/components/searchbar.dart';
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
                ),
                const SizedBox(height: 10),
                CustomComponent(
                  title: 'Title',
                  description: 'Description',
                  backgroundImageUrl:
                      'https:\/\/cdn.akamai.steamstatic.com\/steam\/apps\/990080\/page_bg_generated_v6b.jpg?t=1676412613',
                  imagePath: Images.heroImg,
                  onPressed: () {},
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
                      return FutureBuilder<Map<String, dynamic>>(
                        future: fetchAppDetails(appIds[index]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final gameName = snapshot.data!['name'];
                            final gameImage = snapshot.data!['image'];
                            final background = snapshot.data!['background'];
                            final dev = snapshot.data!['developers'];
                            final free = snapshot.data!['free'];
                            return GameCard(
                              appId: appIds[index].toString(),
                              gameName: gameName,
                              gameImage: gameImage,
                              backgroundImage: background,
                              gameEditor: dev,
                              free: free,
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }
}
