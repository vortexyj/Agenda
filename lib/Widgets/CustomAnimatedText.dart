import 'package:flutter/material.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

class CustomAnimatedText extends StatelessWidget {
  CustomAnimatedText({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: const TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
      totalRepeatCount: 1,
      pause: const Duration(milliseconds: 1000),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    );
  }
}
