import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future SharedValues(String value) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('action', value);
}
