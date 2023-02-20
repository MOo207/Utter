import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:utter/firebase_options.dart';
import 'package:utter/services/auth_service.dart';
import 'package:utter/utils/global.dart';
import 'package:utter/views/home_page.dart';
import 'package:utter/views/signup_login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Utter());
}

class Utter extends StatefulWidget {
  const Utter({super.key});

  @override
  UtterState createState() => UtterState();
}

class UtterState extends State<Utter> {
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: navKey,
      theme: ThemeData(
        // custom purple color
        primarySwatch: Colors.purple,
        primaryColor: Color.fromARGB(255, 111, 96, 211),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const SignupLoginPage();
          }
        },
      )
    );
  }
}