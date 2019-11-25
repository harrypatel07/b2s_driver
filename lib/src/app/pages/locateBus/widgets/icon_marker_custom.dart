import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//exam:
//await IconMarkerCustom('1'),
Future<BitmapDescriptor> iconMarkerCustom(
    {@required IconData icon,
    Color backgroundColor,
    Color color,
    Color strokeColor}) async {
  final double width = 200.0;
  final double height = 200.0;
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint = new Paint()
    ..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5
    ..style = PaintingStyle.stroke;
  canvas.drawLine(
      Offset(width / 2, height / 2), Offset(width / 2, height), paint);
  Paint complete = new Paint()
    ..color = backgroundColor ?? Colors.deepOrange
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.fill;
  Offset center = new Offset(width / 2, width / 2);
  double radius = min(width / 3.5, height / 3.5);

  double arcAngle = 2 * pi * (1);
  canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
      arcAngle, false, complete);
  canvas.drawArc(
      new Rect.fromCircle(
          center: new Offset(width / 2, width / 2),
          radius: min(width / 3.5, height / 3.5)),
      -pi / 2,
      2 * pi * (1),
      false,
      new Paint()
        ..color = strokeColor ?? Colors.white
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7);
  Offset center1 = new Offset(width / 2, height - 5);
  double radius1 = min(10.0, 10.0);
  canvas.drawArc(
      new Rect.fromCircle(center: center1, radius: radius1),
      -pi / 2,
      2 * pi * (1),
      false,
      new Paint()
        ..color = Colors.black
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill);
  TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
  painter.text = TextSpan(
    text: String.fromCharCode(icon.codePoint),
    style: TextStyle(
        fontSize: 50.0,
        color: color ?? Colors.white,
        fontWeight: FontWeight.w900,
        fontFamily: icon.fontFamily),
  );
  painter.layout();
  painter.paint(
      canvas,
      Offset((width * 0.5) - painter.width * 0.5,
          (height * 0.5) - painter.height * 0.5));
  final img = await pictureRecorder
      .endRecording()
      .toImage(width.toInt(), height.toInt());
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
}

Future<BitmapDescriptor> iconMarkerCustomText(
    {@required String text,
    Color backgroundColor,
    Color color,
    Color strokeColor}) async {
  final double width = 200.0;
  final double height = 200.0;
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint = new Paint()
    ..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5
    ..style = PaintingStyle.stroke;
  canvas.drawLine(
      Offset(width / 2, height * 0.8), Offset(width / 2, height), paint);
  Paint complete = new Paint()
    ..color = backgroundColor ?? Colors.deepOrange
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.fill;
  Offset center = new Offset(width / 2, width / 2);
  double radius = min(width / 3.5, height / 3.5);

  double arcAngle = 2 * pi * (1);
  canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
      arcAngle, false, complete);
  canvas.drawArc(
      new Rect.fromCircle(
          center: new Offset(width / 2, width / 2),
          radius: min(width / 3.5, height / 3.5)),
      -pi / 2,
      2 * pi * (1),
      false,
      new Paint()
        ..color = strokeColor ?? Colors.white
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7);
  Offset center1 = new Offset(width / 2, height - 5);
  double radius1 = min(10.0, 10.0);
  canvas.drawArc(
      new Rect.fromCircle(center: center1, radius: radius1),
      -pi / 2,
      2 * pi * (1),
      false,
      new Paint()
        ..color = Colors.black
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill);
  TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
  painter.text = TextSpan(
    text: text,
    style: TextStyle(
        fontSize: 50.0,
        color: color ?? Colors.white,
        fontWeight: FontWeight.w900),
  );
  painter.layout();
  painter.paint(
      canvas,
      Offset((width * 0.5) - painter.width * 0.5,
          (height * 0.5) - painter.height * 0.5));
  final img = await pictureRecorder
      .endRecording()
      .toImage(width.toInt(), height.toInt());
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
}
