import 'package:agenda_v2/Helper/Constants.dart';
import 'package:agenda_v2/Helper/Showbar.dart';
import 'package:agenda_v2/Models/GetModel.dart';
import 'package:agenda_v2/Widgets/CustomAnimatedText.dart';
import 'package:agenda_v2/Widgets/CustomButton.dart';
import 'package:agenda_v2/Widgets/CustomContainer.dart';
import 'package:agenda_v2/Widgets/CustomContainerSearch.dart';
import 'package:agenda_v2/Widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});
  static String ID = 'SearchPage';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DateTime? _selectedDate;
  String Day = '';
  String Month = '';
  String Year = '';

  //user id
  final user = FirebaseAuth.instance.currentUser;
  //access the folder in database
  final ref = FirebaseDatabase.instance.ref(Kdata);
  //object of modeldata we made
  GetModel? getmodel;
  //decleration of the texts
  String item = 'No Data';
  String category = 'No Data';
  String dates = 'No Data';
  String price = 'No Data';
  double TotPrice = 0;
  bool checkData = false;
  //time
  DateTime now = new DateTime.now();

  //data list contain data
  List<GetModel> data = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CustomAnimatedText(text: 'Pick a day'),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 1),
                      child: DatePickerWidget(
                        looping: false, // default is not looping
                        firstDate: DateTime(2022, 01, 01),
                        lastDate: DateTime(2030, 1, 1),
                        initialDate: DateTime(now.year, now.month, 1),
                        dateFormat: "dd-MMM-yyyy",
                        locale: DatePicker.localeFromString('en'),
                        onChange: (DateTime newDate, _) =>
                            _selectedDate = newDate,
                        pickerTheme: DateTimePickerTheme(
                          itemTextStyle:
                              TextStyle(color: Colors.black, fontSize: 19),
                          dividerColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CustomButton(
                Texts: 'sumbit',
                onPressed: () {
                  try {
                    setState(() {
                      try {} catch (e) {}
                      data.clear();

                      TotPrice = 0;
                      Day = _selectedDate!.day.toString();
                      Month = _selectedDate!.month.toString();
                      Year = _selectedDate!.year.toString();
                      ref.child(user!.uid).onValue.listen((event) async {
                        for (var child in event.snapshot.children) {
                          if (child.child('Day').value.toString() == Day &&
                              child.child('Month').value.toString() == Month &&
                              child.child('Year').value.toString() == Year) {
                            getmodel = new GetModel(
                              child.child('Category').value.toString(),
                              child.child('Item').value.toString(),
                              child.child('Date').value.toString(),
                              double.parse(
                                  child.child('Price').value.toString()),
                              child.child('Day').value.toString(),
                              child.child('Month').value.toString(),
                              child.child('Year').value.toString(),
                              int.parse(child.child('Number').value.toString()),
                            );

                            TotPrice = TotPrice +
                                double.parse(
                                    child.child('Price').value.toString());
                            //set the data to the data array
                            data.add(getmodel!);
                            checkData = true;
                          }
                        }

                        if (!checkData) {
                          ShowBar(
                              context, 'No data in this day try another day !');
                        }
                        if (data.isEmpty) {
                          ShowBar(
                              context, 'Press Again if it doesn\'t show up !');
                        }
                      });
                    });
                  } catch (e) {
                    ShowBar(context, 'There was an error');
                    ShowBar(context, 'select a day if you haven\'t');
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return CustomContainerSearch(
                      onTap: () {},
                      dates: data[index].getDate.toString(),
                      category: data[index].getCategory.toString(),
                      item: data[index].getItem.toString(),
                      price: data[index].getPrice.toString());
                },
              ),
            ),
            Container(
              color: Colors.black87,
              height: 35,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Price: $TotPrice L.E',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
