import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/buttons/connection_button.dart';
import '../components/textfields/login_textfield.dart';
import '../resources/resources.dart';
import '../services/firebase_auth_methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginUser() {
    FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.backgroundImg),
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
                  const Text('Bienvenue !',
                      style: TextStyle(
                        fontSize: 30.53,
                        fontFamily: 'GoogleSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 20),
                  const SizedBox(
                    width: 200,
                    child: Text(
                        'Veuillez vous connecter ou créer un nouveau compte pour utiliser l’application.',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 15.27,
                          fontFamily: 'Proxima',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),

                  // EMAIL

                  const SizedBox(height: 40),
                  LoginTextField(
                    hintText: 'E-mail',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                  ),

                  // PASSWORD
                  const SizedBox(height: 10),
                  LoginTextField(
                    hintText: 'Mot de passe',
                    controller: _passwordController,
                    obscureText: true,
                  ),

                  //LOGIN BUTTON
                  const SizedBox(height: 70),
                  ConnectionButton(
                    buttonText: 'Se connecter',
                    onPressed: loginUser,
                    filled: true,
                  ),

                  // Create account
                  const SizedBox(height: 10),
                  ConnectionButton(
                    buttonText: 'Créer un nouveau compte',
                    filled: false,
                    onPressed: loginUser,
                  ),

                  // FORGOTTEN PASSWORD
                  const SizedBox(height: 170),
                  GestureDetector(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/fpassword');
                          },
                          child: const Text(
                            'Mot de passe oublié',
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
              ),
            ))));
  }
}
