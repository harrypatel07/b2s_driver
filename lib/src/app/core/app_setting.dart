library appsetting;

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

final LocalStorage localStorage = new LocalStorage("localStorage");
String domainApi = "http://sales24.odoo24.vn";
final String ggKey = "AIzaSyCjB1Kh7OstaDns8ie6uPysWEWa_vwS3iw";
const emptyState = {
  'assetImage': AssetImage('assets/images/empty.png'),
  'assetPath': 'assets/images/empty.png',
};
