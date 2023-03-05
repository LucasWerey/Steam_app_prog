import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_auth_methods.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(user.uid),
        ElevatedButton(
          onPressed: () async {
            await context.read<FirebaseAuthMethods>().signOut(context);
          },
          child: const Text('Se déconnecter'),
        ),
      ],
    ));
  }
}
