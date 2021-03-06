import 'dart:io';
import 'dart:ui';

import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/ts24_button_widget.dart';
import 'package:flutter/material.dart';

class ReportLocalBus extends StatefulWidget {
  final String title1;
  final String title2;
  final String title3;
  final String value1;
  final String value2;
  final String value3;
  final Widget content1;
  final Widget content2;
  final Widget content3;

  const ReportLocalBus(
      {Key key,
      this.title1,
      this.title2,
      this.title3,
      this.content1,
      this.content2,
      this.content3,
      this.value1,
      this.value2,
      this.value3})
      : super(key: key);

  @override
  _ReportLocalBusState createState() => _ReportLocalBusState();
}

class _ReportLocalBusState extends State<ReportLocalBus> {
//  AnimationController _controller;
//  CurvedAnimation animation;
//  Animation<double> _animation;
  int positionClick = -1;
  @override
  void initState() {
//    _controller =
//        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//    animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//    _animation = Tween(begin: 1.6, end: 0.0).animate(animation)
//      ..addListener(() {
//        setState(() {
//          _animation.value;
//        });
//      });
//    animation.curve = Curves.bounceOut;
//    Timer(const Duration(milliseconds: 200), () {
//      controller.reset();
//      controller.forward();
//    });
    super.initState();
  }

  @override
  void dispose() {
//    _controller.dispose();
    super.dispose();
  }

  onClickItem(int position) {
    setState(() {
      if (positionClick != position) {
        positionClick = position;
//        _controller.reset();
//        _controller.forward();
      } else
        positionClick = -1;
//        switch(position){
//          case 1:
//            positionClick = 1;
//            break;
//          case 2:
//            positionClick = 2;
//            break;
//          case 3:
//            positionClick = 3;
//            break;
//        }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget __report() {
      ___textStyle(int position) {
        return TextStyle(
            fontSize: 16,
            color: positionClick == position
                ? Colors.white
                : ThemePrimary.primaryColor);
      }

      ___numberStyle(int position) {
        return TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: positionClick == position
                ? Colors.white
                : ThemePrimary.primaryColor);
      }

      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            (Platform.isAndroid || Platform.isFuchsia)
                ? ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        height: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)? 120:80,
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        width: MediaQuery.of(context).size.width,
//              color: Colors.transparent,
                        child: SafeArea(
                          top: true,
                          bottom: false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: TS24Button(
                                  onTap: () {
                                    onClickItem(1);
                                  },
                                  decoration: BoxDecoration(
                                      color: positionClick == 1
                                          ? ThemePrimary.primaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.zero),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                        child: Text(
                                          widget.title1,
                                          textAlign: TextAlign.center,
                                          style: ___textStyle(1),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                        child: Text(
                                          widget.value1,
                                          textAlign: TextAlign.center,
                                          style: ___numberStyle(1),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: TS24Button(
                                  onTap: () {
                                    onClickItem(2);
                                  },
                                  decoration: BoxDecoration(
                                      color: positionClick == 2
                                          ? ThemePrimary.primaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.zero),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                        child: Text(
                                          widget.title2,
                                          textAlign: TextAlign.center,
                                          style: ___textStyle(2),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                        child: Text(
                                          widget.value2,
                                          textAlign: TextAlign.center,
                                          style: ___numberStyle(2),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: TS24Button(
                                  onTap: () {
                                    onClickItem(3);
                                  },
                                  decoration: BoxDecoration(
                                      color: positionClick == 3
                                          ? ThemePrimary.primaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.zero),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                        child: Text(
                                          widget.title3,
                                          textAlign: TextAlign.center,
                                          style: ___textStyle(3),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                        child: Text(
                                          widget.value3,
//                                    viewModel.driverBusSession
//                                        .totalChildrenLeave
//                                        .toString(),
                                          textAlign: TextAlign.center,
                                          style: ___numberStyle(3),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
//                              Row(
//                                ],
//                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: (MediaQuery.of(context).orientation ==
                        Orientation.portrait)? 130:70,
                    color: Colors.white54,
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    width: MediaQuery.of(context).size.width,
//              color: Colors.transparent,
                    child: SafeArea(
                      top: true,
                      bottom: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: TS24Button(
                              onTap: () {
                                onClickItem(1);
                              },
                              decoration: BoxDecoration(
                                  color: positionClick == 1
                                      ? ThemePrimary.primaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.zero),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      widget.title1,
                                      textAlign: TextAlign.center,
                                      style: ___textStyle(1),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      widget.value1,
                                      textAlign: TextAlign.center,
                                      style: ___numberStyle(1),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: TS24Button(
                              onTap: () {
                                onClickItem(2);
                              },
                              decoration: BoxDecoration(
                                  color: positionClick == 2
                                      ? ThemePrimary.primaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.zero),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      widget.title2,
                                      textAlign: TextAlign.center,
                                      style: ___textStyle(2),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      widget.value2,
                                      textAlign: TextAlign.center,
                                      style: ___numberStyle(2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: TS24Button(
                              onTap: () {
                                onClickItem(3);
                              },
                              decoration: BoxDecoration(
                                  color: positionClick == 3
                                      ? ThemePrimary.primaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.zero),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      widget.title3,
                                      textAlign: TextAlign.center,
                                      style: ___textStyle(3),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      widget.value3,
//                                    viewModel.driverBusSession
//                                        .totalChildrenLeave
//                                        .toString(),
                                      textAlign: TextAlign.center,
                                      style: ___numberStyle(3),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
//                              Row(
//                                ],
//                              ),
                        ],
                      ),
                    ),
                  ),
            if (positionClick != -1)
              Expanded(
//                flex: 8,
                child: Container(
                  color: ThemePrimary.primaryColor,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: positionClick == 1
                            ? widget.content1
                            : positionClick == 2
                                ? widget.content2
                                : widget.content3,
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                positionClick = -1;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: SafeArea(
                                bottom: true,
                                top: false,
                                child: Center(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ThemePrimary.colorParentApp,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius:
                                              1.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              1.0, // has the effect of extending the shadow
                                          offset: Offset(
                                            -1.0, // horizontal, move right 10
                                            -1.0, // vertical, move down 10
                                          ),
                                        ),
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius:
                                              1.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              1.0, // has the effect of extending the shadow
                                          offset: Offset(
                                            1.0, // horizontal, move right 10
                                            1.0, // vertical, move down 10
                                          ),
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      );
    }

    return __report();
  }
}
