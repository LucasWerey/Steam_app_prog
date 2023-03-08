import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      Navigator.of(context).pop();
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
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      Navigator.of(context).pop();
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
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
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
      showSnackBar(context, 'Veuillez entrer une adresse email valide');
      Navigator.of(context).pop();
    }
  }
}
