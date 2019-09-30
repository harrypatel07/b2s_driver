import 'package:flutter/cupertino.dart';

class ListContentClipper extends CustomClipper<Path> {
  final double radius = 10;
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height / 2);
    //path.lineTo(size.width, 0);
    // path.lineTo(size.width, 100);
    // path.addOval(
    //     Rect.fromCircle(center: Offset(0.0, size.height / 2), radius: radius));
    // path.addOval(Rect.fromCircle(
    //     center: Offset(size.width, size.height / 2), radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
