import 'package:agenda_v2/Screens/LoginPage.dart';
import 'package:agenda_v2/Widgets/CustomText.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.Texts,
    this.onPressed,
  });

  VoidCallback? onPressed;
  final String Texts;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 214, 214, 214),
        minimumSize: Size(150, 50),
      ),
      onPressed: onPressed,
      child: TextWidget(Texts: Texts, colors: Colors.black, Size: 20),
    );
  }
}
