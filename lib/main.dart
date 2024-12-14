import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with different options for web
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDM_RLzh3r5SNXzsaIKCBwBNI-NrRTKxKg",
        appId: "1:618183878810:web:77906c59d6a0bc35bdd723",
        messagingSenderId: "618183878810",
        projectId: "demo1-40f51",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(GymFitnessApp());
}

class GymFitnessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Times New Roman', // Added consistent font styling
      ),
      home: WelcomeScreen(), // Start with the Welcome Screen
    );
  }
}
