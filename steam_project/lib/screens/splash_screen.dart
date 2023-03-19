import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steam_project/screens/home_screen.dart';
import 'package:steam_project/screens/login_screen.dart';

import '../resources/resources.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (firebaseUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 14, 15, 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage('assets/gif/loader.gif'),
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
