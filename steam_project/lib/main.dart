import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steam_project/screens/likes_screen.dart';
import 'package:steam_project/screens/lostpass_screen.dart';
import 'package:steam_project/screens/search_screen.dart';
import 'package:steam_project/screens/splash_screen.dart';
import 'package:steam_project/screens/wishlist_screen.dart';
import 'package:steam_project/services/firebase_auth_methods.dart';
import 'firebase_options.dart';
import './screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null)
      ],
      child: MaterialApp(
        title: 'firstRoute',
        debugShowCheckedModeBanner: false,
        home: const Splash(),
        routes: <String, WidgetBuilder>{
          "/signup": (BuildContext context) => const SignUpPage(),
          "/fpassword": (BuildContext context) => const Fpass(),
          "/wishlist": (BuildContext context) => const WishListPage(),
          "/like": (BuildContext context) => const LikesPage(),
          'search_screen': (context) => const SearchPage(),
        },
      ),
    );
  }
}
