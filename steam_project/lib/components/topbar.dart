import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../resources/resources.dart';
import '../services/firebase_auth_methods.dart';
import 'buttons/svg_button.dart';

class TopBar extends StatelessWidget {
  final Function onSignOutPressed; // Ajouter la fonction de rappel

  const TopBar({super.key, required this.onSignOutPressed}); // Modifier le constructeur

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: SvgClickableComponent(
                svgPath: VectorialImages.like,
                onPressed: () {
                  Navigator.pushNamed(context, '/like');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgClickableComponent(
                svgPath: VectorialImages.whishlist,
                onPressed: () {
                  Navigator.pushNamed(context, '/wishlist');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgClickableComponent(
                svgPath: VectorialImages.power,
                onPressed: () {
                  FirebaseAuthMethods(FirebaseAuth.instance).signOut(context);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ]),
    );
  }
}
