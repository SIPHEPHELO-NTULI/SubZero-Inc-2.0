import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Screens/Home/home_screen.dart';

//main() used to initialize Firebase database connection
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDLKFzDKlIhfF8JB1ulVfEbIpQoCsPZuyY",
        authDomain: "flutterwebdemo-75af3.firebaseapp.com",
        projectId: "flutterwebdemo-75af3",
        storageBucket: "flutterwebdemo-75af3.appspot.com",
        messagingSenderId: "935726076849",
        appId: "1:935726076849:web:7433fb268a599575982390"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Give A Little",
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 3, 79, 255),
          visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}
