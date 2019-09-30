import 'package:flutter/material.dart';

class LeavePage extends StatefulWidget {
  static const String routeName = "/leave";

  @override
  _LeavePageState createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Leave"),
      ),
      body: Container(),
    );
  }
}
