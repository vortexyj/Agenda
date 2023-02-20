import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:agenda_v2/Helper/Constants.dart';
import 'package:agenda_v2/Helper/Showbar.dart';
import 'package:agenda_v2/Models/GetModel.dart';
import 'package:agenda_v2/Screens/SearchPage.dart';
import 'package:agenda_v2/Widgets/CustomAnimatedText.dart';
import 'package:agenda_v2/Widgets/CustomButton.dart';
import 'package:agenda_v2/Widgets/CustomContainer.dart';
import 'package:agenda_v2/Widgets/CustomDropDown.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SummaryPage extends StatefulWidget {
  SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  String dropdownValue = Days.first;
  //exit and enter the network
  StreamSubscription? _streamSubscription;

  //user id
  final user = FirebaseAuth.instance.currentUser;
  //access the folder in database
  final ref = FirebaseDatabase.instance.ref(Kdata);
  //object of modeldata we made
  GetModel? getmodel;

  //data list contain data
  List<GetModel> data = [];
//decleration of the texts
  String item = 'No Data';
  String category = 'No Data';
  String dates = 'No Data';
  String price = 'No Data';
  double TotPrice = 0;
  bool TodaysCheck = false;
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
    _streamSubscription = ref.child(user!.uid).onValue.listen((event) {
      for (var child in event.snapshot.children) {
        if (child.child('Day').value.toString() == now.day.toString()) {
          getmodel = new GetModel(
            child.child('Category').value.toString(),
            child.child('Item').value.toString(),
            child.child('Date').value.toString(),
            double.parse(child.child('Price').value.toString()),
            child.child('Day').value.toString(),
            child.child('Month').value.toString(),
            child.child('Year').value.toString(),
            int.parse(child.child('Number').value.toString()),
          );
          TodaysCheck = true;
          //set the data to the data array
          data.add(getmodel!);
        }
      }
      if (!TodaysCheck) {
        ShowBar(context, 'No Records today');
      }
      setState(() {});
      //loop to enter all the childrens avalable
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ID);
            },
            icon: Icon(Icons.search),
            color: Colors.black,
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            CustomAnimatedText(text: 'Summary'),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return CustomContainer(
                      onTap: () {
                        try {
                          FirebaseDatabase.instance
                              .ref(Kdata)
                              .child(user!.uid)
                              .child(data[index].getNumber.toString())
                              .remove();
                          data.removeAt(index);
                        } catch (e) {
                          ShowBar(
                              context, 'there was an error deleting this $e');
                        }
                      },
                      dates: data[index].getDate.toString(),
                      category: data[index].getCategory.toString(),
                      item: data[index].getItem.toString(),
                      price: data[index].getPrice.toString());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _streamSubscription?.cancel();
    super.deactivate();
  }
}




//  GestureDetector(
//               onTap: () {
//                 setState(() {
//                   TotPrice = 0;
//                   DateTime now = new DateTime.now();
//                   ref.child(user!.uid).onValue.listen((event) {
//                     for (var child in event.snapshot.children) {
//                       if (child.child('Day').value.toString() ==
//                           now.day.toString()) {
//                         TotPrice = double.parse(
//                                 child.child('Price').value.toString()) +
//                             TotPrice;
//                       }
//                     }
//                   });
//                 });
//               },
//               child: Container(
//                 child: Text(TotPrice.toString()),
//               ),
//             ),