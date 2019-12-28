import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String message;

  const EmptyWidget({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(30),
            alignment: Alignment.center,
            child: Image.asset("assets/images/empty.png"),
          ),
          Container(
            child: Center(
              child: Text(
                message,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                    color: Colors.grey.withOpacity(0.6)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
