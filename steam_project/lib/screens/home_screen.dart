import 'package:flutter/material.dart';
import 'package:steam_project/components/searchbar.dart';

import '../../resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final searchController = TextEditingController();

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
                              padding: const EdgeInsets.only(right: 30.0),
                              child: SvgPicture.asset(VectorialImages.like),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child:
                                  SvgPicture.asset(VectorialImages.whishlist),
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
                ]),
              ),
            )));
  }
}
