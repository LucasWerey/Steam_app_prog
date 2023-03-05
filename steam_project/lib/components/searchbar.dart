import 'package:flutter/material.dart';

import '../../resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: camel_case_types
class Search_Bar extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText; //'Rechercher un jeu'
  //final bool obscureText; //pour cacher ce qu'on saisit (mdp)

  const Search_Bar({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                textAlign: TextAlign.left,
                controller: controller,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Proxima',
                    fontSize: 12.92),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.52),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.52),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1.0),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 30, 38, 44),
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Proxima',
                    fontSize: 12.92,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(VectorialImages.search),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
