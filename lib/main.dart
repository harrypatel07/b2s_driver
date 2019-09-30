import 'package:b2s_driver/src/app/app.dart';
import 'package:b2s_driver/src/app/app_localizations.dart';
import 'package:flutter/material.dart';

Future main() async {
  await translation.init('vi');
  runApp(MyApp());
}
