import 'package:flutter/material.dart';
import './screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import './services/firebase_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetIt.instance.registerSingleton<FirebaseService>(FirebaseService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto - Black'
      ),
      home: const Scaffold(
        body: WelcomeScreen(),
        
      ),
    );
  }
}

