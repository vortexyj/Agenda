import 'dart:ffi';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agenda_v2/Helper/Showbar.dart';
import 'package:agenda_v2/Widgets/CustomAnimatedText.dart';
import 'package:agenda_v2/Widgets/CustomButton.dart';
import 'package:agenda_v2/Widgets/CustomDropDown.dart';
import 'package:agenda_v2/Widgets/CustomText.dart';
import 'package:agenda_v2/Widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:agenda_v2/Helper/Constants.dart';

class AddingitemsPage extends StatefulWidget {
  AddingitemsPage({super.key});
  static String ID = 'AddingitemsPage';

  @override
  State<AddingitemsPage> createState() => _AddingitemsPageState();
}

class _AddingitemsPageState extends State<AddingitemsPage> {
  final user = FirebaseAuth.instance.currentUser;

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref(Kdata);
  int Counter = 0;
  String? Items;
  String? _chosenValue;
  double? Price;

  TextEditingController _controller = new TextEditingController();

  TextEditingController _controller2 = new TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey();

  String dropdownValue = Categorieslists.first;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    //time
    DateTime now = new DateTime.now();
    String date = now.toString().substring(0, 10);
    String times = now.toString().substring(10, 19);

    //add data to the model and making list of it
    ref.child(user!.uid).onValue.listen((event) {
      //loop to enter all the childrens avalable
      for (var child in event.snapshot.children) {
        Counter = int.parse(child.child('Number').value.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    String date = now.toString().substring(0, 10);
    String Day = now.day.toString();
    String Month = now.month.toString();
    String Year = now.year.toString();

    String times = now.toString().substring(10, 19);
    return Scaffold(
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: [
            SizedBox(
              height: 40,
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAnimatedText(text: 'Whats New ?'),
              ],
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
            ),
            CustomDropDownBox(
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
                ShowBar(context, dropdownValue.toString());
              },
              dropdownValue: dropdownValue,
            ),
            SizedBox(
              height: 20,
              width: double.infinity,
            ),
            CustomTextField(
              onChanged: (data) {
                Items = data;
              },
              type: TextInputType.name,
              controller: _controller,
              hintText: 'item',
              Icons: Icons.shopping_bag,
            ),
            SizedBox(
              height: 20,
              width: double.infinity,
            ),
            CustomTextField(
              onChanged: (data) {
                try {
                  Price = double.parse(data);
                } catch (e) {
                  ShowBar(context, 'please enter numbers and dots only !');
                }
              },
              type: TextInputType.number,
              hintText: 'Price',
              controller: _controller2,
              Icons: Icons.payments,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
            ),
            CustomButton(
              Texts: 'Sumbit',
              onPressed: (() async {
                await ref.child(user!.uid).child((Counter + 1).toString()).set({
                  'Category': dropdownValue,
                  'Item': Items,
                  'Price': Price,
                  'Date': date,
                  'Day': Day,
                  'Month': Month,
                  'Year': Year,
                  'Number': Counter + 1,
                });

                _controller.clear();
                _controller2.clear();
              }),
            ),
            /*CustomButton(
              Texts: 'Sumbit',
              onPressed: (() {
                ShowBar(context, times);
              }),
            ),*/
            SizedBox(
              height: 50,
              width: double.infinity,
            ),
          ]),
        ),
      ),
    );
  }
}
