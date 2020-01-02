import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/ts24_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoticeLocalBus extends StatefulWidget {
  final Function onTap;
  final Widget content;
  const NoticeLocalBus({Key key, this.onTap, this.content}) : super(key: key);
  @override
  _NoticeLocalBusState createState() => _NoticeLocalBusState();
}

class _NoticeLocalBusState extends State<NoticeLocalBus> {
  int positionClick = -1;
  double a = 0.0;
  bool isShow = true;
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          if (isShow)
            Positioned(
              right: 57,
//              top: 10,
//              bottom: 10,
              child: InkWell(
                onTap: widget.onTap,
                child: Container(
                  alignment: Alignment.centerLeft,
//                  padding:
//                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0)),
                  width: MediaQuery.of(context).size.width - 60,
                  child: widget.content,
                ),
              ),
//              ),
            ),
          Positioned(
            top: 10,
            right: 0,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: new BoxDecoration(
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.black38,
//                      blurRadius: 1.0, // has the effect of softening the shadow
//                      spreadRadius:
//                          1.0, // has the effect of extending the shadow
//                      offset: Offset(
//                        -1.0, // horizontal, move right 10
//                        -1.0, // vertical, move down 10
//                      ),
//                    )
//                  ],
                      color: Colors.black12,
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40))),
                  width: 60,
                  height: 60,
                ),
                Positioned(
                  top: 4,
                  left: 2,
                  child: TS24Button(
                    width: 50,
                    height: 50,
                    onTap: () {
                      setState(() {
                        isShow = !isShow;
                      });
                    },
                    decoration: BoxDecoration(
                      color: ThemePrimary.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Center(
                      child: isShow
                          ? Icon(
                              FontAwesomeIcons.angleDoubleRight,
                              size: 17,
                              color: Colors.white,
                            )
                          : Icon(
                              FontAwesomeIcons.angleDoubleLeft,
                              size: 17,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
