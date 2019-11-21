import 'dart:async';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/pages/home/popup_card_timeline/popup_card_timeline_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PopupCardTimeLinePage extends StatefulWidget {
  static const String routeName = "/popupProfile";
  final ProfileChildrenDetailArgs arguments;
  PopupCardTimeLinePage(this.arguments);

  @override
  _PopupCardTimeLinePageState createState() =>
      _PopupCardTimeLinePageState();
}
class ProfileChildrenDetailArgs {
  final Offset offset;
  final HomePageCardTimeLine homePageCardTimeLine;
  ProfileChildrenDetailArgs({this.offset, this.homePageCardTimeLine});
}
class _PopupCardTimeLinePageState extends State<PopupCardTimeLinePage>
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
    _animation = Tween(begin: -0.2, end: 1.0).animate(animation)
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
          onTap: () {
            launch('tel:${viewModel.homePageCardTimeLine.children.parent.phone}');
          },
          child: Container(
            decoration: new BoxDecoration(
                color: ThemePrimary.primaryColor,
                borderRadius:
                    new BorderRadius.only(bottomLeft: Radius.circular(70))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(alignment: Alignment.center, child: Icon(Icons.call,color: Colors.white,size: 15,)),
                SizedBox(
                  width: 5,
                ),
                Container(alignment: Alignment.center, child: Text('Gọi',style: TextStyle(color: Colors.white,fontSize: 12),))
              ],
            ),
          ),
        );
      }

      Widget _buttonLeave() {
        return GestureDetector(
          onTap: () {
            viewModel.onTapLeave();
          },
          child: Container(
            padding: EdgeInsets.only(right: 10),
            decoration: new BoxDecoration(
                color: viewModel.homePageCardTimeLine.status.statusID == 0? Colors.red:Colors.grey,
                borderRadius:
                    new BorderRadius.only(bottomRight: Radius.circular(70))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(alignment: Alignment.center, child: Icon(Icons.home,color: Colors.white,size: 15,)),
                SizedBox(
                  width: 5,
                ),
                Container(alignment: Alignment.center, child: Text('Nghỉ',style: TextStyle(color: Colors.white,fontSize: 12),))
              ],
            ),
          ),
        );
      }

      Widget _buttonSms() {
        return GestureDetector(
          onTap: () {
            launch('sms:${viewModel.homePageCardTimeLine.children.parent.phone}');
          },
          child: Container(
            color: Colors.orange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(alignment: Alignment.center, child: Icon(Icons.sms,color: Colors.white,size: 15,)),
                SizedBox(
                  width: 5,
                ),
                Container(alignment: Alignment.center, child: Text('SMS',style: TextStyle(color: Colors.white,fontSize: 12),))
              ],
            ),
          ),
        );
      }
      Widget _buttonChat() {
        return GestureDetector(
          onTap: () {
            viewModel.onTapChat();
          },
          child: Container(
            color: ThemePrimary.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(alignment: Alignment.center, child: Icon(FontAwesomeIcons.facebookMessenger,color: Colors.white,size: 15,)),
                SizedBox(
                  width: 5,
                ),
                Container(alignment: Alignment.center, child: Text('Chat',style: TextStyle(color: Colors.white,fontSize: 12),))
              ],
            ),
          ),
        );
      }
      return Transform.translate(
        offset: Offset(0, _animation.value * 50),
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width - 84,
          margin: EdgeInsets.only(left: 25),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  bottomRight: Radius.circular(70),
                  bottomLeft: Radius.circular(70))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(top:  5),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 20,),
                      Container(
                        width: 40,
                        height: 40,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: null,
                            child: CachedNetworkImage(
                              imageUrl: viewModel.homePageCardTimeLine.children.parent.photo,
                              imageBuilder: (context, imageProvider) => CircleAvatar(
                                radius: 35.0,
                                backgroundImage: imageProvider,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(viewModel.homePageCardTimeLine.children.parent.name + "fsdf sfsdf sfsdf fsdf",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,),
                      ),
                      SizedBox(width: 10,)
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
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
                      child: _buttonChat(),
                    ),
                    Expanded(
                      flex: 1,
                      child: _buttonLeave(),
                    ),
                  ],
                ),
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
                        height: 92,
                        width: MediaQuery.of(context).size.width - 54,
                        child:
                        HomePageCardTimeLine(
                            children: viewModel.homePageCardTimeLine.children,
                            //isEnablePicked: status.statusID == 0 ? true : false,
                            status: viewModel.status,
                            heroTag: viewModel.homePageCardTimeLine.heroTag,
                            typePickDrop: viewModel.homePageCardTimeLine.typePickDrop,
                            isEnableTapChildrenContentCard: false,
                            cardType: viewModel.homePageCardTimeLine.cardType,
                            onTapPickUp: () {
                              viewModel.onTapPicked();
                              viewModel.homePageCardTimeLine.onTapPickUp();
                            },
                            onTapChangeStatusLeave: (){
                              viewModel.onTapChangeStatus(3);
                            },
                        ),
//                        HomePageCardTimeLine(
//                          children: viewModel.children,
//                          isEnablePicked:
//                              viewModel.status.statusID == 0 ? true : false,
//                          status: viewModel.status,
//                          onTapPickUp: () {
//                            viewModel.onTapPicked();
//                            widget.arguments.homePageCardTimeLine.onTapPickUp();
//                          },
//                        ),
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

