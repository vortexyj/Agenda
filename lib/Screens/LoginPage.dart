import 'package:agenda_v2/Screens/AddingPage.dart';
import 'package:agenda_v2/Screens/RegisterPage.dart';
import 'package:agenda_v2/Widgets/CustomButton.dart';
import 'package:agenda_v2/Widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:agenda_v2/Helper/Showbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:agenda_v2/Widgets/CustomAnimatedText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String ID = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  text: 'Welcome Back',
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
              onChanged: (data) {
                Password = data;
              },
              type: TextInputType.visiblePassword,
              hintText: 'Password',
              Icons: Icons.password,
            ),
            SizedBox(height: 30),
            CustomButton(
              Texts: 'Login',
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  try {
                    await RegisiterUser();
                    Navigator.pushNamed(context, AddingPage.ID,
                        arguments: Email);
                    ShowBar(context, 'Success');
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      ShowBar(context, 'User not found');
                    } else if (e.code == 'worng-password') {
                      ShowBar(context, 'Worng Password');
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
            SizedBox(height: 15),
            Center(child: Text('Forgot Your Password ?')),
            SizedBox(height: 15),
            Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RegistierPage.ID);
                  },
                  child: Text(
                    'Register ?',
                    style: TextStyle(color: Colors.blue),
                  )),
            ),
            SizedBox(height: 90),
          ],
        ),
      ),
    ));
  }

  Future<void> RegisiterUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: Email!, password: Password!);
  }
}
