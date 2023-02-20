import 'dart:ffi';

import 'package:flutter/foundation.dart';

class GetModel {
  String? Category, Date, Item, Day, Month, Year;
  double? Price;
  int? Number;

  GetModel(String Category, String Item, String Date, double Price, String Day,
      String Month, String Year, int Number) {
    this.Category = Category;
    this.Date = Date;
    this.Item = Item;
    this.Price = Price;
    this.Day = Day;
    this.Month = Month;
    this.Year = Year;
    this.Number = Number;
  }

  String? get getCategory {
    return Category;
  }

  set setCategory(String category) {
    Category = category;
  }

  String? get getDate {
    return Date;
  }

  set setDate(String date) {
    Date = date;
  }

  String? get getItem {
    return Item;
  }

  set setItem(String item) {
    Item = item;
  }

  double? get getPrice {
    return Price;
  }

  set setPrice(double price) {
    Price = price;
  }

  String? get getDay {
    return Day;
  }

  set setDay(String day) {
    Day = day;
  }

  String? get getMonth {
    return Month;
  }

  set setMonth(String month) {
    Month = month;
  }

  String? get getYear {
    return Year;
  }

  set setYear(String year) {
    Year = year;
  }

  int? get getNumber {
    return Number;
  }

  set setNumber(int number) {
    Number = number;
  }
}
