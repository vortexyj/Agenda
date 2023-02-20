import 'package:agenda_v2/Screens/AddingPage.dart';
import 'package:agenda_v2/Screens/LoginPage.dart';
import 'package:agenda_v2/Screens/RegisterPage.dart';
import 'package:agenda_v2/Widgets/CustomAnimatedText.dart';
import 'package:agenda_v2/Widgets/CustomButton.dart';
import 'package:agenda_v2/Widgets/CustomText.dart';
import 'package:agenda_v2/Widgets/CustomAnimatedText.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static String ID = 'HomePage';

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    if (user?.uid == null) {
      return Scaffold(
        appBar: null,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomAnimatedText(text: 'Agenda'),
              SizedBox(
                height: 50,
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                      Texts: 'Login',
                      onPressed: () => Navigator.pushNamed(
                            context,
                            LoginPage.ID,
                          )),
                  CustomButton(
                      Texts: 'Registier',
                      onPressed: () => Navigator.pushNamed(
                            context,
                            RegistierPage.ID,
                          )),
                ],
              )
            ],
          ),
        ),
      );
    } else {
      return AddingPage();
    }
  }
}
