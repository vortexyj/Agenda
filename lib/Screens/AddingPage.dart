import 'package:agenda_v2/Screens/Additems.dart';
import 'package:agenda_v2/Screens/SettingsPage.dart';
import 'package:agenda_v2/Screens/SummaryPage.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:agenda_v2/Helper/ShowWidgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AddingPage extends StatefulWidget {
  AddingPage({super.key});
  static String ID = 'AddingPage';

  @override
  State<AddingPage> createState() => _AddingPageState();
}

class _AddingPageState extends State<AddingPage> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  FirebaseDatabase database = FirebaseDatabase.instance;

  DatabaseReference ref = FirebaseDatabase.instance.ref();

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var Email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        height: 60,
        items: [
          Icon(
            Icons.add,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.settings,
            size: 30,
            color: Colors.black,
          ),
        ],
      ),
      body: showwidget(_page),
    );
  }
}
