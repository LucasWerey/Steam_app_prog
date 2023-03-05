import 'package:flutter/material.dart';

import '../../resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishlistPage extends StatelessWidget {
  WishlistPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
                      width: 400,
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
                        Row(children: [
                          const SizedBox(width: 12),
                          SvgPicture.asset(VectorialImages.close),
                          const SizedBox(width: 16),
                          const Text('Ma liste de souhaits',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                        ]),
                        const SizedBox(height: 20)
                      ])),
                  const SizedBox(height: 20),
                  const SizedBox(height: 200),
                  SvgPicture.asset(VectorialImages.emptyWhishlist),
                  const SizedBox(height: 65),
                  const SizedBox(
                    width: 300,
                    child: Text("Vous n'avez pas encore liké de contenu.",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 15.27,
                          fontFamily: 'Proxima',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(height: 13),
                  const SizedBox(
                    width: 300,
                    child: Text("Cliquez sur l'étoile pour en rajouter.",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 15.27,
                          fontFamily: 'Proxima',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                ]),
              ),
            )));
  }
}
