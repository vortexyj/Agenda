import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:agenda_v2/Helper/Constants.dart';

class CustomDropDownBox extends StatelessWidget {
  CustomDropDownBox({required this.onChanged, required this.dropdownValue});

  final Function(String?) onChanged;

  final String dropdownValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: dropdownValue,
      icon: const Icon(
        Icons.arrow_downward,
        color: Colors.blue,
      ),
      elevation: 16,
      onChanged: onChanged,
      items: Categorieslists.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}
