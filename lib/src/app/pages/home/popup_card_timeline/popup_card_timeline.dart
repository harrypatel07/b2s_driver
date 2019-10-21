import 'dart:async';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/pages/home/popup_card_timeline/popup_card_timeline_viewmodel.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageCardTimeLineDetail extends StatefulWidget {
  static const String routeName = "/popupProfile";
  final ProfileChildrenDetailArgs arguments;
  HomePageCardTimeLineDetail(this.arguments);

  @override
  _HomePageCardTimeLineDetailState createState() =>
      _HomePageCardTimeLineDetailState();
}

class _HomePageCardTimeLineDetailState extends State<HomePageCardTimeLineDetail>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation animation;
  Animation<double> _animation;
  PopupCardTimeLineViewModel viewModel;
  @override
  void initState() {
    viewModel = PopupCardTimeLineViewModel(widget.arguments);
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    _animation = Tween(begin: 0.0, end: 1.0).animate(animation)
      ..addListener(() {
        _animation.value;
        viewModel.updateState();
      });
    animation.curve = Curves.bounceOut;
    Timer(const Duration(milliseconds: 200), () {
      controller.reset();
      controller.forward();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _bottomButton() {
      Widget _buttonCall() {
        return GestureDetector(
          onTap: (){
            launch('tel:0123456');
          },
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.green,
                borderRadius: new BorderRadius.only(
                    bottomLeft: Radius.circular(70))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: Icon(Icons.call)
                ),
                SizedBox(width: 5,),
                Container(
                    alignment: Alignment.center,
                    child: Text('Gọi')
                )
              ],
            ),
          ),
        );
      }
      Widget _buttonLeave() {
        return GestureDetector(
          onTap: (){
            viewModel.onTapChangeStatus(3);
            widget.arguments.homePageCardTimeLine.onTapChangeStatusLeave();
          },
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: new BorderRadius.only(
                    bottomRight: Radius.circular(70))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: Icon(Icons.check)
                ),
                SizedBox(width: 5,),
                Container(
                    alignment: Alignment.center,
                    child: Text('Nghỉ')
                )
              ],
            ),
          ),
        );
      }
      Widget _buttonSms() {
        return GestureDetector(
          onTap: (){
            launch('sms:0123456');
          },
          child: Container(
            color: Colors.yellow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: Icon(Icons.sms)
                ),
                SizedBox(width: 5,),
                Container(
                    alignment: Alignment.center,
                    child: Text('SMS')
                )
              ],
            ),
          ),
        );
      }
      return Transform.translate(
        offset: Offset(0, _animation.value * 50),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 80,
          margin: EdgeInsets.only(left: 25),
          decoration: new BoxDecoration(
              //color: Colors.white,
              borderRadius: new BorderRadius.only(
                  bottomRight: Radius.circular(70),
                  bottomLeft: Radius.circular(70))),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: _buttonCall(),
              ),
              Expanded(
                flex: 1,
                child: _buttonSms(),
              ),
              Expanded(
                flex: 1,
                child: _buttonLeave(),
              ),
            ],
          ),
        ),
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                color: Colors.black54,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context);
                        print("Tap background");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                    ),
                    Positioned(
                      top: viewModel.position.dy - 5 + 30,
                      left: viewModel.position.dx - 5,
                      child: _bottomButton(),
                    ),
                    Positioned(
                      top: viewModel.position.dy - 5,
                      left: viewModel.position.dx - 5,
                      child: Container(
                        height: 90,
                        width: MediaQuery.of(context).size.width - 50,
                        child: HomePageCardTimeLine(
                          children: viewModel.children,
                          isEnablePicked:
                              viewModel.status.statusID == 0 ? true : false,
                          status: viewModel.status,
                          isEnableTapChildrenContentCard: false,
                          onTapPickUp: () {
                            viewModel.onTapPicked();
                            widget.arguments.homePageCardTimeLine.onTapPickUp();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}

class ProfileChildrenDetailArgs {
  final Offset offset;
  final HomePageCardTimeLine homePageCardTimeLine;
  ProfileChildrenDetailArgs({this.offset, this.homePageCardTimeLine});
}
