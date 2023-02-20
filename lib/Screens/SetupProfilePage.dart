import 'package:agenda_v2/Helper/Showbar.dart';
import 'package:agenda_v2/Screens/AddingPage.dart';
import 'package:agenda_v2/Screens/LoginPage.dart';
import 'package:agenda_v2/Widgets/CustomButton.dart';
import 'package:agenda_v2/Widgets/CustomTextField.dart';

import 'package:agenda_v2/Widgets/CustomAnimatedText.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SetupProfilePage extends StatelessWidget {
  SetupProfilePage({super.key});
  static String ID = 'SetupProfilePage';
  GlobalKey<FormState> formkey = GlobalKey();
  final user = FirebaseAuth.instance.currentUser;

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users");
  var uid;
  String? Username;
  String? Phonenumber;

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      uid = user?.uid;
    }
    var Email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: [
            SizedBox(
              height: 75,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAnimatedText(
                  text: 'SetupProfile',
                ),
              ],
            ),
            SizedBox(height: 75),
            CustomTextField(
              onChanged: (data) {
                Username = data;
              },
              type: TextInputType.name,
              hintText: 'UserName',
              Icons: Icons.person,
            ),
            SizedBox(height: 20),
            CustomTextField(
              onChanged: (data) {
                Phonenumber = data;
              },
              type: TextInputType.phone,
              hintText: 'Phone Number',
              Icons: Icons.phone,
            ),
            SizedBox(height: 30),
            CustomButton(
              Texts: 'Sumbit',
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  try {
                    await ref.child(uid).set({
                      "Email": Email.toString(),
                      "UserName": Username,
                      "PhoneNumber": Phonenumber,
                      "UserID": uid.toString(),
                    });
                    Navigator.pushNamed(context, AddingPage.ID);
                    ShowBar(context, 'Done !');
                  } catch (e) {
                    ShowBar(context, 'there was an error $e');
                  }
                }
              },
            ),
            SizedBox(height: 80),
          ]),
        ),
      ),
    );
  }
}
