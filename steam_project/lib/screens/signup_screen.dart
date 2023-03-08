import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/buttons/connection_button.dart';
import '../components/textfields/login_textfield.dart';
import '../services/firebase_auth_methods.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpScreen createState() => SignUpScreen();
}

class SignUpScreen extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    if (passwordController.text != password2Controller.text) {
    } else {
      FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/BackgroundImg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: SafeArea(
                child: Center(
              child: Column(children: [
                const SizedBox(height: 60),
                const Text('Inscription',
                    style: TextStyle(
                      fontSize: 30.53,
                      fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                const SizedBox(height: 20),
                const SizedBox(
                  width: 300,
                  child: Text(
                      'Veuillez saisir ces différentes informations, afin que vos listes soient sauvegardées.',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 15.27,
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
                // Nom d'utilisateur
                const SizedBox(height: 50),
                LoginTextField(
                  hintText: "Nom d'utilisateur",
                  controller: usernameController,
                  obscureText: false,
                ),
                // Email
                const SizedBox(height: 10),
                LoginTextField(
                  hintText: "Email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                ),
                // Password
                const SizedBox(height: 10),
                LoginTextField(
                  hintText: "Mot de passe",
                  controller: passwordController,
                  obscureText: true,
                ),
                // Verif Password
                const SizedBox(height: 30),
                LoginTextField(
                  hintText: "Vérification du mot de passe",
                  controller: password2Controller,
                  obscureText: true,
                ),

                const SizedBox(height: 75),
                ConnectionButton(
                  buttonText: "S'inscrire",
                  onPressed: signUpUser,
                  filled: true,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Retour',
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                  color: Color.fromARGB(255, 175, 184, 187),
                                  offset: Offset(0, -2))
                            ],
                            color: Colors.transparent,
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromARGB(255, 175, 184, 187),
                            decorationThickness: 1,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                        ))),
              ]),
            ))));
  }
}
