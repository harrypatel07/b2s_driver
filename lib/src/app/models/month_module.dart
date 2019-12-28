import 'package:flutter/material.dart';

class MonthModule {
  DateTime date;
  //0 empty
  //1 left
  //2 full
  //3 right
  Color color;
  bool isSelected;
  int typeDraw;
  MonthModule(this.date);
}
