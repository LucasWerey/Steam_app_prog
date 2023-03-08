import 'package:flutter/material.dart';
import '../components/buttons/connection_button.dart';
import '../components/textfields/login_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_auth_methods.dart';

class Fpass extends StatefulWidget {
  const Fpass({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Fpass createState() => _Fpass();
}

class _Fpass extends State<Fpass> {
  final emailController = TextEditingController();

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
                  child: Column(
                children: [
                  const SizedBox(height: 60),
                  const Text('Mot de passe oublié',
                      style: TextStyle(
                        fontSize: 30.53,
                        fontFamily: 'GoogleSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 20),
                  const SizedBox(
                    width: 352.29,
                    child: Text('Veuillez saisir votre email',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 15.27,
                          fontFamily: 'Proxima',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    width: 352.29,
                    child: Text('afin de réinitialiser votre mot de passe.',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 15.27,
                          fontFamily: 'Proxima',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(height: 50),
                  //EMAIL
                  LoginTextField(
                    hintText: 'E-mail',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                  ),
                  // Resend button
                  const SizedBox(height: 70),
                  ConnectionButton(
                    buttonText: 'Renvoyer mon mot de passe',
                    onPressed: resetPassword,
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
                              decorationColor:
                                  Color.fromARGB(255, 175, 184, 187),
                              decorationThickness: 1,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ))),
                ],
              )),
            )));
  }

  void resetPassword() {
    FirebaseAuthMethods(FirebaseAuth.instance)
        .resetPassword(email: emailController.text, context: context);
  }
}
