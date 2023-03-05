import 'package:flutter/material.dart';
import 'package:steam_project/components/searchbar.dart';
import '../components/buttons/svg_button.dart';
import '../resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  void signOut() {
    FirebaseAuthMethods(FirebaseAuth.instance).signOut(context);
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
              child: Center(
                child: Column(children: [
                  Container(
                      height: 65,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                              width: 2,
                              color: Color.fromARGB(97, 0, 0, 0),
                              style: BorderStyle.solid),
                        ),
                      ),
                      child: Column(children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Text(
                                'Accueil',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'GoogleSans',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: SvgPicture.asset(VectorialImages.like),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child:
                                  SvgPicture.asset(VectorialImages.whishlist),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: SvgClickableComponent(
                                svgPath: VectorialImages.power,
                                onPressed: signOut,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ])),
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
                    imagePath: Images.HeroImg,
                    onPressed: () {},
                  ),
                ]),
              ),
            )));
  }
}
