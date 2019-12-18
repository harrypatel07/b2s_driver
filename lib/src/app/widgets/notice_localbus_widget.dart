import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/ts24_button_widget.dart';
import 'package:flutter/material.dart';

class NoticeLocalBus extends StatefulWidget {
  final Function onTap;
  final Widget content;
  const NoticeLocalBus({Key key, this.onTap, this.content}) : super(key: key);
  @override
  _NoticeLocalBusState createState() => _NoticeLocalBusState();
}

class _NoticeLocalBusState extends State<NoticeLocalBus> {
  int positionClick = -1;
  double valueClose = 0.0;
  double valueOpen = 0.9;
  double a = 0.0;
  bool isShow = false;
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: <Widget>[
          if (isShow)
            Positioned(
              right: 30,
              child: InkWell(
                onTap: widget.onTap,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.only(left: 15, right: 30, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0)),
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: widget.content,
                ),
              ),
            ),
          Positioned(
            right: 5,
            top: 20,
            child: RaisedButton(
                onPressed: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
                child: Icon(isShow ? Icons.close : Icons.expand_more),
                color: ThemePrimary.primaryColor,
                shape: CircleBorder()),
          )
        ],
      ),
    );
  }
}
