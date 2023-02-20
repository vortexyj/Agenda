import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {required this.Texts, required this.colors, required this.Size});
  final String Texts;
  final Color colors;
  final double Size;

  @override
  Widget build(BuildContext context) {
    return Text(
      Texts,
      style: TextStyle(color: colors, fontSize: Size),
    );
  }
}
