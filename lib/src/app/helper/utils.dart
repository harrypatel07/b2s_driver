import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

Future<Uint8List> readFileByte(String filePath) async {
  Uri myUri = Uri.parse(filePath);
  File audioFile = new File.fromUri(myUri);
  Uint8List bytes;
  await audioFile.readAsBytes().then((value) {
    bytes = Uint8List.fromList(value);
    print('reading of bytes is completed');
  }).catchError((onError) {
    print(
        'Exception Error while reading audio from path:' + onError.toString());
  });
  return bytes;
}

bool getPointInCircle({Offset center, double r, Offset positionCurrent}) {
  double distance = (pow((positionCurrent.dx - center.dx), 2) +
          pow((positionCurrent.dy - center.dy), 2))
      .abs();
  return distance <= r * r;
}

bool dateDifferent(DateTime dateTimeA, DateTime dateTimeB) {
  if (dateTimeA.day != dateTimeB.day ||
      dateTimeA.month != dateTimeB.month ||
      dateTimeA.year != dateTimeB.year) return true;
  return false;
}
