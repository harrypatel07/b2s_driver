import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:b2s_driver/src/app/widgets/notice_localbus_widget.dart';
import 'package:b2s_driver/src/app/widgets/report_localbus_widget.dart';
import 'package:b2s_driver/src/app/widgets/ts24_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocateBusPage extends StatefulWidget {
  static const String routeName = "/locateBus";
  final DriverBusSession driverBusSession;

  const LocateBusPage({Key key, this.driverBusSession}) : super(key: key);
  @override
  _LocateBusPageState createState() => _LocateBusPageState();
}

class _LocateBusPageState extends State<LocateBusPage>
    with SingleTickerProviderStateMixin {
  LocateBusPageViewModel viewModel = LocateBusPageViewModel();

  @override
  void initState() {
    viewModel.driverBusSession = widget.driverBusSession;
    viewModel.driverBusSessionInput = viewModel.driverBusSession;
    //viewModel.listenData();
    viewModel.onCreateDriverBusSessionReport();
    viewModel.listenData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget __buildGoogleMap() {
      return GoogleMap(
        onMapCreated: viewModel.onMapCreated,
        myLocationEnabled: viewModel.myLocationEnabled ? true : false,
        myLocationButtonEnabled: false,
        compassEnabled: true,
        markers: Set<Marker>.of(viewModel.markers.values),
        polylines: Set<Polyline>.of(viewModel.polyline.values),
        onTap: (lat) {
          var coord = lat;
          print('${coord.latitude}, ${coord.longitude}');
        },
        initialCameraPosition: CameraPosition(
          target: viewModel.center,
          zoom: 13.0,
        ),
      );
    }

    Widget __backButton() {
      return Positioned(
        bottom: 0,
        left: 0,
        child: SafeArea(
          bottom: false,
          top: true,
          child: TS24Button(
            onTap: () {
              viewModel.onTapBackButton();
            },
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  topRight: Radius.circular(25)),
              color: ThemePrimary.primaryColor,
            ),
            width: 70,
            height: 50,
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    Widget __contentReport(List<Children> listChildren) {
      return Container(
        color: ThemePrimary.primaryColor,
        height: MediaQuery.of(context).size.height * 0.87,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ...listChildren
                  .asMap()
                  .map((index, children) {
//                  var status = ChildDrenStatus.getStatusByChildrenID(
//                      viewModel.driverBusSession.childDrenStatus,
//                      children.id,
//                      children.id);
//                  var statusBus =
//                      StatusBus.getStatusByID(StatusBus.list, status.statusID);
                    return MapEntry(
                        index,
                        HomePageCardTimeLine(
                          children: children,
                          isEnablePicked: false,
                          //heroTag: index.toString(),
                          onTapPickUp: () {
//                  viewModel.onTapPickUp(driverBusSession, children, item);
                          },
                          onTapChangeStatusLeave: () {
//                  viewModel.onTapChangeChildrenStatus(
//                      driverBusSession, children, item, 3);
//                  print("show button call");
                          },
                          onTapShowChildrenProfile: () {
//                viewModel.onTapShowChildrenProfile(children, tag);
                          },
                        ));
                  })
                  .values
                  .toList(),
            ],
          ),
        ),
      );
    }

    Widget __notice() {
      int pointNext = viewModel.getPointNextPick();
      return Positioned(
        right: 0,
        top: 10,
        child: NoticeLocalBus(
          onTap: () {
            if (pointNext != -1)
              viewModel.onTapNoticeContent(
                  viewModel.getRouteBusPointNext(), pointNext);
          },
          content: RichText(
              text: (pointNext != -1)
                  ? new TextSpan(
                      style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        new TextSpan(text: 'Điểm đón tiếp theo: '),
                        new TextSpan(
                            text: 'Điểm số ${pointNext.toString()}\n',
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ThemePrimary.primaryColor)),
                        new TextSpan(text: 'Địa chỉ: '),
                        new TextSpan(
                            text: '${viewModel.getAddressPointNext()}\n',
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ThemePrimary.primaryColor)),
                        new TextSpan(text: 'Học sinh cần đón: '),
                        new TextSpan(
                            text:
                                '${viewModel.getCountChildrenPickPointNext().toString()}\n',
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ThemePrimary.primaryColor)),
                        new TextSpan(text: 'Học sinh phải trả: '),
                        new TextSpan(
                            text:
                                '${viewModel.getCountChildrenDropPointNext().toString()}',
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ThemePrimary.primaryColor)),
                      ],
                    )
                  : new TextSpan(
                      style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                          TextSpan(
                            text:
                                '\nXin vui lòng bấm kết thúc để hoàn thành chuyến đi.\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ThemePrimary.primaryColor,
                            ),
                          ),
                        ])),
        ),
      );
    }

    Widget __report() {
      return Positioned(
        top: 0,
        child: ReportLocalBus(
          title1: 'Học sinh đăng ký',
          title2: 'Học sinh trên xe',
          title3: 'Học sinh báo nghỉ',
          value1: viewModel.driverBusSession.totalChildrenRegistered.toString(),
          value2: viewModel.driverBusSession.totalChildrenInBus.toString(),
          value3: viewModel.driverBusSession.totalChildrenLeave.toString(),
          content1: __contentReport(viewModel.driverBusSession.listChildren),
          content2: __contentReport(viewModel.getListChildrenByStatusID(1)),
          content3: __contentReport(viewModel.getListChildrenByStatusID(3)),
        ),
      );
    }

    Widget __navigateGoogleMap() {
      return Positioned(
        right: 0,
        top: 175,
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: ThemePrimary.primaryColor),
                onTap: () {
                  viewModel.onTapGoogleMaps();
                },
                child: Center(
                  child: Icon(
                    Icons.near_me,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget __finishButton() {
      return Positioned(
        bottom: -10,
        right: MediaQuery.of(context).size.width / 2 - 50,
        child: SafeArea(
          bottom: true,
          child: TS24Button(
            width: 100,
            height: 80,
            onTap: () {
              viewModel.onTapFinish();
            },
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1.0, // has the effect of softening the shadow
                    spreadRadius: 1.0, // has the effect of extending the shadow
                    offset: Offset(
                      -1.0, // horizontal, move right 10
                      -1.0, // vertical, move down 10
                    ),
                  ),
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1.0, // has the effect of softening the shadow
                    spreadRadius: 1.0, // has the effect of extending the shadow
                    offset: Offset(
                      1.0, // horizontal, move right 10
                      1.0, // vertical, move down 10
                    ),
                  )
                ],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50)),
                color: ThemePrimary.primaryColor),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.fingerprint,
                    color: Color(0xff065e49),
                    size: 70,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, right: 15, left: 15),
                  child: Text(
                    'KẾT THÚC',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
//        InkWell(
//          onTap: () {
//            viewModel.onTapFinish();
//          },
//          child: Container(
//            alignment: Alignment.topCenter,
//            width: 100,
//            height: 100,
//            decoration: BoxDecoration(boxShadow: [
//              BoxShadow(
//                color: Colors.black12,
//                blurRadius: 1.0, // has the effect of softening the shadow
//                spreadRadius: 1.0, // has the effect of extending the shadow
//                offset: Offset(
//                  -1.0, // horizontal, move right 10
//                  -1.0, // vertical, move down 10
//                ),
//              ),
//              BoxShadow(
//                color: Colors.black12,
//                blurRadius: 1.0, // has the effect of softening the shadow
//                spreadRadius: 1.0, // has the effect of extending the shadow
//                offset: Offset(
//                  1.0, // horizontal, move right 10
//                  1.0, // vertical, move down 10
//                ),
//              )
//            ], shape: BoxShape.circle, color: ThemePrimary.primaryColor),
//            child: Stack(
//              children: <Widget>[
//                Align(
//                  alignment: Alignment.topCenter,
//                  child: Icon(
//                    Icons.fingerprint,
//                    color: Color(0xff065e49),
//                    size: 70,
//                  ),
//                ),
//                Padding(
//                  padding: EdgeInsets.only(top: 15, right: 15, left: 15),
//                  child: Text(
//                    'KẾT THÚC',
//                    style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 16,
//                        fontWeight: FontWeight.bold),
//                    textAlign: TextAlign.center,
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
      );
    }

    Widget __sosButton() {
      return Positioned(
        top: 100,
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
                  viewModel.onTapSOS();
                },
                decoration: BoxDecoration(
                  color: Colors.red[300],
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Center(
                  child: Text(
                    "SOS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.yellow, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget __buildIconLocation() {
      return Positioned(
        right: 15,
        top: 250,
        child: SizedBox(
          width: 40,
          height: 40,
          child: FloatingActionButton(
            child: Icon(
              Icons.gps_fixed,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: viewModel.animateMyLocation,
            backgroundColor: Colors.white,
          ),
        ),
      );
    }

    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return WillPopScope(
                child: new TS24Scaffold(
                  body: Stack(
                    children: <Widget>[
                      viewModel.showGoolgeMap
                          ? __buildGoogleMap()
                          : Container(),
                      Positioned(
                        right: 0,
                        top: 90,
                        child: Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: <Widget>[
                              __notice(),
                              __navigateGoogleMap(),
                              __sosButton(),
                              __buildIconLocation(),
                            ],
                          ),
                        ),
                      ),
                      __backButton(),
                      __finishButton(),
                      __report(),
                      viewModel.showSpinner
                          ? LoadingIndicator.progress(
                              context: context,
                              loading: true,
                              position: Alignment.topCenter)
                          : Container(),
//                    if(viewModel.listTimeLine!=null)_builBottomSheet()
                    ],
                  ),
                  //body: Container()
                ),
                onWillPop: () async {
                  viewModel.onTapBackButton();
                  return false;
                });
          }),
    );
  }
}
