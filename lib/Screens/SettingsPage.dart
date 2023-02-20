import 'dart:async';

import 'package:agenda_v2/Screens/LoginPage.dart';
import 'package:agenda_v2/Widgets/CustomAnimatedText.dart';
import 'package:agenda_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CustomAnimatedText(text: 'Settings')],
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                if (Navigator.canPop(context)) {
                  Navigator.pushNamed(context, LoginPage.ID);
                }
              },
              child: Container(
                width: double.infinity,
                height: 40,
                child: Row(
                  children: [
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
