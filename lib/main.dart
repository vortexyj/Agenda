import 'package:agenda_v2/Screens/AddingPage.dart';
import 'package:agenda_v2/Screens/LoginPage.dart';
import 'package:agenda_v2/Screens/RegisterPage.dart';
import 'package:agenda_v2/Screens/SearchPage.dart';
import 'package:agenda_v2/Screens/SetupProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'Screens/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Agenda());
}

class Agenda extends StatefulWidget {
  const Agenda({super.key});

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomePage.ID: (context) => HomePage(),
        LoginPage.ID: (context) => LoginPage(),
        RegistierPage.ID: (context) => RegistierPage(),
        AddingPage.ID: (context) => AddingPage(),
        SetupProfilePage.ID: (context) => SetupProfilePage(),
        SearchPage.ID: (context) => SearchPage(),
      },
      initialRoute: HomePage.ID, // home Page
      theme: ThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
    );
  }
}
