import 'package:agenda_v2/Helper/Constants.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:agenda_v2/Screens/SummaryPage.dart';
import 'package:flutter/material.dart';

class CustomContainerSearch extends StatelessWidget {
  CustomContainerSearch(
      {required this.dates,
      required this.category,
      required this.item,
      required this.price,
      required this.onTap});

  final String dates;
  final String item;
  final String category;
  final String price;
  final VoidCallback onTap;
  String? PhotoPath;

  @override
  Widget build(BuildContext context) {
    if (category == 'Entertainment') {
      PhotoPath = Kentertainmenticon;
    } else if (category == 'Food') {
      PhotoPath = Kfoodicon;
    } else if (category == 'Zakaa') {
      PhotoPath = Kdonateicon;
    } else if (category == 'Others') {
      PhotoPath = Kothereicon;
    }
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image(
                image: AssetImage(PhotoPath!),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      item,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dates,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$price L.E',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
