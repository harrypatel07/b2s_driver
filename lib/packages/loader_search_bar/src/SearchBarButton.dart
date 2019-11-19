import 'package:flutter/material.dart';

class SearchBarButton extends StatelessWidget {
  SearchBarButton({
    this.icon,
    this.color,
    this.onPressed,
    this.marginHorizontal = 0.0,
  });

  final IconData icon;
  final Color color;
  final GestureTapCallback onPressed;
  final double marginHorizontal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Container(
            child: Icon(icon, color: color, size: 24.0),
          ),
        ),
      ),
    );
  }
}
