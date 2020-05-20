
import 'package:flutter/material.dart';

class TS24Button extends StatelessWidget{
  final BoxDecoration decoration;
  final double width;
  final double height;
  final Function onTap;
  final Widget child;
  final Alignment alignment;
  final EdgeInsetsDirectional padding;
  final EdgeInsetsGeometry margin;

  const TS24Button({Key key,@required this.decoration,this.onTap,this.child,this.width,this.height,this.padding,this.margin,this.alignment}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: decoration,
      alignment: alignment,
      child: Material(
        shape: decoration.border,
        borderRadius: decoration.borderRadius,
        color: Colors.transparent,
        child: InkWell(
          borderRadius: decoration.borderRadius,
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }

}