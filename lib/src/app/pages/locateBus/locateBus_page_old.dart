//import 'dart:async';
//
//import 'package:b2s_driver/src/app/core/baseViewModel.dart';
//import 'package:b2s_driver/src/app/models/busTimeLine.dart';
//import 'package:b2s_driver/src/app/models/driverBusSession.dart';
//import 'package:b2s_driver/src/app/models/statusBus.dart';
//import 'package:b2s_driver/src/app/pages/home/widgets/timeline_widget.dart';
//import 'package:b2s_driver/src/app/pages/locateBus/emergency/emergency_page.dart';
//import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page_viewmodel.dart';
//import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';
//import 'package:b2s_driver/src/app/theme/theme_primary.dart';
//import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
//import 'package:b2s_driver/src/app/widgets/index.dart';
//import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:sliding_up_panel/sliding_up_panel.dart';
//
//class LocateBusPageOld extends StatefulWidget {
//  static const String routeName = "/locateBus";
//
//  @override
//  _LocateBusPageOldState createState() => _LocateBusPageOldState();
//}
//
//class _LocateBusPageOldState extends State<LocateBusPageOld>
//    with SingleTickerProviderStateMixin {
//  LocateBusPageViewModel viewModel = LocateBusPageViewModel();
//  BusTimeLine busTimeLine;
//  final double _initFabHeight = 100.0;
//  double _fabHeight;
//  double _panelHeightOpen = 0;
//  double _panelHeightClosed = 120.0;
//
//  ScrollController _sc = ScrollController();
//  PanelController _pc = PanelController();
//  bool disableScroll = true;
//  AnimationController animationController;
//  CurvedAnimation curvedAnimation;
//  Animation<double> animation;
//  @override
//  void dispose() {
//    _sc.dispose();
//    animationController.dispose();
//    super.dispose();
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    _fabHeight = _initFabHeight;
//    _sc.addListener(() {
//      // if (_pc.isPanelOpen()) {
//      //   setState(() {
//      //     disableScroll = _sc.offset <= 0;
//      //   });
//      // }
//    });
//    busTimeLine = new BusTimeLine();
//    busTimeLine.percent = 0.0;
//    busTimeLine.routBusIndex = 1;
//    animationController =
//        AnimationController(vsync: this, duration: Duration(seconds: 60));
//    animationController.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        animationController.stop();
//      }
//      // else if (status == AnimationStatus.dismissed) {
//      //   animationController.forward();
//      // }
//    });
//    // curvedAnimation =
//    //     CurvedAnimation(parent: animationController, curve: Curves.easeIn);
//    // animation = Tween(begin: 0.0, end: 100.0).animate(curvedAnimation)
//    //   ..addListener(() {
//    //     setState(() {
//    //       busTimeLine.percent = animation.value;
//    //     });
//    //   });
//    // curvedAnimation.curve = Curves.ease;
//    Future.delayed(Duration(seconds: 2), () {
//      animationController.forward();
//    });
//    // Timer(const Duration(seconds: 30), () {
//    //   animationController.reset();
//    //   animationController.forward();
//    // });
//    // double percent = 0;
//    // Timer.periodic(new Duration(seconds: 2), (timer) {
//    //   if (percent == 100) timer.cancel();
//    //   percent += 1;
//    //   setState(() {
//    //     busTimeLine.percent = percent;
//    //   });
//    // });
//  }
//
//  Widget _buildBody() {
//    Widget __buildGoogleMap() {
//      return GoogleMap(
//        onMapCreated: viewModel.onMapCreated,
//        myLocationEnabled: viewModel.myLocationEnabled ? true : false,
//        myLocationButtonEnabled: false,
//        compassEnabled: true,
//        markers: Set<Marker>.of(viewModel.markers.values),
//        polylines: Set<Polyline>.of(viewModel.polyline.values),
//        onTap: (lat) {
//          var coord = lat;
//          print('${coord.latitude}, ${coord.longitude}');
//        },
//        initialCameraPosition: CameraPosition(
//          target: viewModel.center,
//          zoom: 13.0,
//        ),
//      );
//    }
//
//    Widget __report() {
//      final ___textStyle =
//          TextStyle(fontSize: 16, color: ThemePrimary.primaryColor);
//      final ___numberStyle = TextStyle(
//          fontSize: 20,
//          fontWeight: FontWeight.w900,
//          color: ThemePrimary.primaryColor);
//      return Positioned(
//        top: 0,
//        child: Container(
//          padding: EdgeInsets.fromLTRB(15, 30, 15, 5),
//          width: MediaQuery.of(context).size.width,
//          color: Colors.white54,
//          child: Column(
//            children: <Widget>[
//              Row(
//                children: <Widget>[
//                  Expanded(
//                    flex: 1,
//                    child: Container(
//                      padding: EdgeInsets.only(left: 20, right: 20),
//                      child: Text(
//                        "Học sinh đăng ký",
//                        textAlign: TextAlign.center,
//                        style: ___textStyle,
//                      ),
//                    ),
//                  ),
//                  Expanded(
//                    flex: 1,
//                    child: Container(
//                      padding: EdgeInsets.only(left: 20, right: 20),
//                      child: Text(
//                        "Học sinh trên xe",
//                        textAlign: TextAlign.center,
//                        style: ___textStyle,
//                      ),
//                    ),
//                  ),
//                  Expanded(
//                    flex: 1,
//                    child: Container(
//                      padding: EdgeInsets.only(left: 20, right: 20),
//                      child: Text(
//                        "Học sinh báo nghỉ",
//                        textAlign: TextAlign.center,
//                        style: ___textStyle,
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//              Row(
//                children: <Widget>[
//                  Expanded(
//                    flex: 1,
//                    child: Container(
//                      padding: EdgeInsets.only(left: 20, right: 20, top: 5),
//                      child: Text(
//                        "20",
//                        textAlign: TextAlign.center,
//                        style: ___numberStyle,
//                      ),
//                    ),
//                  ),
//                  Expanded(
//                    flex: 1,
//                    child: Container(
//                      padding: EdgeInsets.only(left: 20, right: 20, top: 5),
//                      child: Text(
//                        "10",
//                        textAlign: TextAlign.center,
//                        style: ___numberStyle,
//                      ),
//                    ),
//                  ),
//                  Expanded(
//                    flex: 1,
//                    child: Container(
//                      padding: EdgeInsets.only(left: 20, right: 20, top: 5),
//                      child: Text(
//                        "02",
//                        textAlign: TextAlign.center,
//                        style: ___numberStyle,
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ],
//          ),
//        ),
//      );
//    }
//
//    Widget __sosButton() {
//      return Positioned(
//        bottom: MediaQuery.of(context).size.height / 2,
//        right: 0,
//        child: Stack(
//          children: <Widget>[
//            Container(
//              padding: EdgeInsets.only(left: 20),
//              decoration: new BoxDecoration(
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
//                  color: Colors.white54,
//                  borderRadius: new BorderRadius.only(
//                      topLeft: Radius.circular(40),
//                      bottomLeft: Radius.circular(40))),
//              width: 60,
//              height: 60,
//            ),
//            Positioned(
//              top: 4,
//              left: 2,
//              child: InkWell(
//                onTap: () {
//                  Navigator.pushNamed(context, EmergencyPage.routeName);
//                  print("On tab SOS");
//                },
//                child: Container(
//                  width: 50,
//                  height: 50,
//                  alignment: Alignment.center,
//                  decoration: new BoxDecoration(
//                    color: Colors.red,
//                    shape: BoxShape.circle,
//                  ),
//                  child: Text(
//                    "SOS",
//                    textAlign: TextAlign.center,
//                    style: TextStyle(
//                        color: Colors.yellow, fontWeight: FontWeight.w900),
//                  ),
//                ),
//              ),
//            ),
//          ],
//        ),
//      );
//    }
//
//    return Stack(
//      children: <Widget>[
//        viewModel.showGoolgeMap ? __buildGoogleMap() : Container(),
//        viewModel.showSpinner
//            ? LoadingIndicator.progress(
//                context: context, loading: true, position: Alignment.topCenter)
//            : Container(),
//        __report(),
//        __sosButton()
//      ],
//    );
//  }
//
//  Widget _buildPanel() {
//    var driverBusSession =
//        DriverBusSession.list.length > 0 ? DriverBusSession.list[0] : null;
//    if (driverBusSession == null) return Container();
//    var listTimeLine = driverBusSession.listRouteBus
//        .map((item) => TimeLineEvent(
//            time: item.time,
//            task: item.routeName,
//            content: viewModel
//                .getListChildrenForTimeLine(driverBusSession, item.id)
//                .map((children) {
//              final statusID = ChildDrenStatus.getStatusIDByChildrenID(
//                  driverBusSession.childDrenStatus, children.id, item.id);
//              final statusBus =
//                  StatusBus.getStatusByID(StatusBus.list, statusID);
//              return HomePageCardTimeLine(
//                children: children,
//                isEnablePicked: statusID == 0 ? true : false,
//                status: statusBus,
//                isEnableTapChildrenContentCard: false,
//                onTapPickUp: () {
//                  viewModel.onTapPickUpChild(driverBusSession, children, item);
//                },
//              );
//            }).toList(),
//            isFinish: item.status))
//        .toList();
//    Widget __childrenCard() {
//      return Stack(
//        children: <Widget>[
//          Container(
//              margin: EdgeInsets.only(top: 25),
//              padding: EdgeInsets.only(top: 5),
//              decoration: new BoxDecoration(
//                color: Colors.grey[200],
//                borderRadius: new BorderRadius.only(
//                  topLeft: Radius.circular(35),
//                  topRight: Radius.circular(35),
//                ),
//              ),
//              height: 430,
//              child: HomePageTimeLineV2(
//                listTimeLine: listTimeLine,
//                busTimeLine: busTimeLine,
//                animationBusController: animationController,
//              )),
//          Positioned(
//            left: MediaQuery.of(context).size.width / 2 - 15,
//            top: 5,
//            child: GestureDetector(
//              // onTap: () {
//              //   _pc.close();
//              // },
//              // onLongPress: () {
//              //   _pc.close();
//              // },
//              onVerticalDragDown: (drag) {
//                _pc.close();
//              },
//              child: Align(
//                alignment: Alignment.center,
//                child: Container(
//                  width: 30,
//                  height: 5,
//                  decoration: BoxDecoration(
//                      color: Colors.grey[300],
//                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
//                ),
//              ),
//            ),
//          ),
//        ],
//      );
//    }
//
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        __childrenCard(),
//      ],
//    );
//  }
//
//  Widget _buildIconLocation() {
//    return Positioned(
//      right: 20.0,
//      bottom: _fabHeight,
//      child: SizedBox(
//        width: 40,
//        height: 40,
//        child: FloatingActionButton(
//          child: Icon(
//            Icons.gps_fixed,
//            color: Theme.of(context).primaryColor,
//          ),
//          onPressed: viewModel.animateMyLocation,
//          backgroundColor: Colors.white,
//        ),
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
////    TabsPageViewModel tabsPageViewModel = ViewModelProvider.of(context);
////    viewModel = tabsPageViewModel.locateBusPageViewModel;
//    _panelHeightOpen = MediaQuery.of(context).size.height * 2 / 3;
//    return StatefulWrapper(
//      onInit: () {},
//      child: ViewModelProvider(
//        viewmodel: viewModel,
//        child: StreamBuilder<Object>(
//            stream: viewModel.stream,
//            builder: (context, snapshot) {
//              return MaterialApp(
//                home: Stack(
//                  children: <Widget>[
//                    SlidingUpPanel(
//                      controller: _pc,
//                      parallaxEnabled: true,
//                      backdropEnabled: true,
//                      parallaxOffset: .5,
//                      maxHeight: _panelHeightOpen,
//                      minHeight: _panelHeightClosed,
//                      borderRadius: BorderRadius.only(
//                          topLeft: Radius.circular(18.0),
//                          topRight: Radius.circular(18.0)),
//                      panel: _buildPanel(),
//                      onPanelOpened: () {
//                        setState(() {
//                          disableScroll = false;
//                        });
//                      },
//                      onPanelClosed: () {
//                        setState(() {
//                          disableScroll = true;
//                        });
//                      },
//                      onPanelSlide: (double pos) => setState(() {
//                        _fabHeight =
//                            pos * (_panelHeightOpen - _panelHeightClosed) +
//                                _initFabHeight;
//                      }),
//                      body: new Scaffold(
//                        body: _buildBody(),
//                        // body: Container()
//                      ),
//                    ),
//                    _buildIconLocation()
//                  ],
//                ),
//              );
//            }),
//      ),
//    );
//  }
//}
