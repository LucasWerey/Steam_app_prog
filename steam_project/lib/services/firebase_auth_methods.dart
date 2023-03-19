// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../utils/showSnackBar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // STATE PERSISTENCE
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  // EMAIL SIGN UP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
        barrierDismissible: false);
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      showSnackBar(context, 'Compte créé avec succès');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'Cet email est déjà utilisé');
        Navigator.pop(context);
      } else if (e.code == 'invalid-email') {
        showSnackBar(context, 'Veuillez entrer une adresse email valide');
        Navigator.pop(context);
      } else if (e.code == 'weak-password') {
        showSnackBar(
            context, 'Le mot de passe doit contenir au moins 6 caractères');
        Navigator.pop(context);
      } else if (e.code == 'network-request-failed') {
        showSnackBar(context, 'Veuillez vérifier votre connexion internet');
        Navigator.of(context).pop();
      }
    }
  }

  //EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
        barrierDismissible: false);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'Aucun utilisateur trouvé pour cet email');
        Navigator.pop(context);
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Mot de passe incorrect');
        Navigator.pop(context);
      } else if (e.code == 'invalid-email') {
        showSnackBar(context, 'Veuillez entrer une adresse email valide');
        Navigator.pop(context);
      } else if (e.code == 'network-request-failed') {
        showSnackBar(context, 'Veuillez vérifier votre connexion internet');
        Navigator.of(context).pop();
      }
    }
  }

  // SIGN OUT

  Future<void> signOut(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
        barrierDismissible: false);
    try {
      await _auth.signOut();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        showSnackBar(context, 'Veuillez vérifier votre connexion internet');
        Navigator.of(context).pop();
      } else {
        showSnackBar(context, e.message!);
      }
      Navigator.of(context).pop();
    }
  }

  // RESET PASSWORD
  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
        barrierDismissible: false);
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSnackBar(context, "Un email de réinitialisation a été envoyé");
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        showSnackBar(context, 'Veuillez vérifier votre connexion internet');
        Navigator.of(context).pop();
      } else if (e.code == 'invalid-email') {
        showSnackBar(context, 'Veuillez entrer une adresse email valide');
        Navigator.of(context).pop();
      } else if (e.code == 'user-not-found') {
        showSnackBar(context, 'Aucun utilisateur trouvé pour cet email');
        Navigator.of(context).pop();
      }
    }
  }
}
