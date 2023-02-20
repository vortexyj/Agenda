import 'package:agenda_v2/Screens/LoginPage.dart';
import 'package:agenda_v2/Screens/SetupProfilePage.dart';
import 'package:agenda_v2/Widgets/CustomAnimatedText.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:agenda_v2/Widgets/CustomButton.dart';
import 'package:agenda_v2/Widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:agenda_v2/Helper/Showbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class RegistierPage extends StatefulWidget {
  RegistierPage({super.key});
  static String ID = 'RegistierPage';

  @override
  State<RegistierPage> createState() => _RegistierPageState();
}

class _RegistierPageState extends State<RegistierPage> {
  String? Email;
  GlobalKey<FormState> formkey = GlobalKey();
  String? Password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: formkey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(
              height: 75,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAnimatedText(
                  text: 'Hi',
                ),
              ],
            ),
            SizedBox(height: 75),
            CustomTextField(
              onChanged: (data) {
                Email = data;
              },
              type: TextInputType.emailAddress,
              hintText: 'Email',
              Icons: Icons.email,
            ),
            SizedBox(height: 20),
            CustomTextField(
              hintText: 'Password',
              type: TextInputType.visiblePassword,
              Icons: Icons.password,
              onChanged: (data) {
                Password = data;
              },
            ),
            SizedBox(height: 30),
            CustomButton(
              Texts: 'Registier',
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  try {
                    await RegisiterUser();
                    ShowBar(context, 'Success');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, SetupProfilePage.ID,
                        arguments: Email);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      ShowBar(context, 'Weak Password');
                    } else if (e.code == 'email-already-in-use') {
                      ShowBar(context, 'Email in used');
                    } else if (e.code == 'invalid-email') {
                      ShowBar(context, 'invalid-email');
                    } else if (e.code == 'operation-not-allowed') {
                      ShowBar(context, 'Not allowed');
                    }
                  } catch (e) {
                    ShowBar(context, 'there was an error');
                  }
                  setState(
                    () {},
                  );
                } else {}
              },
            ),
            SizedBox(height: 90),
          ],
        ),
      ),
    ));
  }

  Future<void> RegisiterUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: Email!, password: Password!);
  }
}
