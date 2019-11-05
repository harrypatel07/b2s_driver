import 'package:flutter/material.dart';

class MonthModule {
  DateTime _date;
  //0 empty
  //1 left
  //2 full
  //3 right
  Color _color;
  bool _isSelected;
  int _typeDraw;
  MonthModule(this._date);

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  int get typeDraw => _typeDraw;

  set typeDraw(int value) {
    _typeDraw = value;
  }

  bool get isSelected => _isSelected;
  set isSelected(bool value) {
    _isSelected = value;
  }

  Color get color => _color;
  set color(Color value) {
    _color = value;
  }
}
