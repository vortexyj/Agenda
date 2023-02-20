import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {required this.hintText,
      required this.type,
      this.Icons,
      this.onChanged,
      this.controller});
  String hintText;
  IconData? Icons;
  TextInputType type;

  TextEditingController? controller;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (data) {
          if (data!.isEmpty) {
            return 'Field is required';
          }
        },
        controller: controller,
        onChanged: onChanged,
        keyboardType: type,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          label: Text(hintText),
          suffixIcon: Icon(
            Icons,
            color: Colors.blue,
          ),
          enabledBorder: OutlineInputBorder(),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ));
  }
}
