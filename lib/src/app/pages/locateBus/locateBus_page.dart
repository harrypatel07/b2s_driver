import 'dart:io';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page_viewmodel.dart';
import 'package:b2s_driver/src/app/service/common-service.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:b2s_driver/src/app/widgets/notice_localbus_widget.dart';
import 'package:b2s_driver/src/app/widgets/report_localbus_widget.dart';
import 'package:b2s_driver/src/app/widgets/ts24_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
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
    // viewModel.increasePointNextPick();
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
        zoomControlsEnabled: false,
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
          left: false,
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
//        height: (MediaQuery.of(context).orientation == Orientation.portrait)
//            ? MediaQuery.of(context).size.height - 144
//            : MediaQuery.of(context).size.height - 124,
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
//      viewModel.increasePointNextPick();
      String time = (viewModel.pointNext > 0)
          ? Common.removeMiliSecond(viewModel
              .driverBusSession.listRouteBus[viewModel.pointNext - 1].time)
          : '';
      return NoticeLocalBus(
        onTap: () {
          viewModel.onTapNoticeContent();
        },
        content: (viewModel.pointNext != -1)
            ? Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Icon(
                              Icons.radio_button_unchecked,
                              size: 28,
                              color: ThemePrimary.primaryColor,
                            ),
                            Container(
//                              color: Colors.yellow,
                              width: 28,
                              height: 28,
                              alignment: Alignment.center,
                              child: Text(
                                viewModel.pointNext.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: ThemePrimary.primaryColor),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            '${viewModel.getAddressPointNext()}',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.arrow_upward,
                          color: ThemePrimary.primaryColor,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          '${viewModel.countChildPick()}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.arrow_downward,
                          color: Colors.yellow[700],
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          '${viewModel.countChildDrop()}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          " $time",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TS24Button(
                          onTap: () {
                            viewModel.showBottomSheetListRoute();
                          },
                          height: 35,
                          decoration: BoxDecoration(
                              color: ThemePrimary.primaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Danh sách điểm',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TS24Button(
                          onTap: () {
                            viewModel.increasePointNextPick();
                          },
                          height: 35,
                          decoration: BoxDecoration(
                              color: ThemePrimary.colorParentApp,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.skip_next,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Điểm tiếp theo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            : Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: RichText(
                    text: new TextSpan(
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
      return Stack(
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
      );
    }

    Widget __connectQrScanDevice() {
      return Positioned(
        bottom: -6,
        right: 0,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20),
              decoration: new BoxDecoration(
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
              child: (viewModel.bluetoothDeviceConnected != null)
                  ? StreamBuilder<BluetoothDeviceState>(
                      stream: viewModel.bluetoothDeviceConnected.state,
                      initialData: BluetoothDeviceState.disconnected,
                      builder: (c, snapshot) {
                        return TS24Button(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: viewModel.isBluetoothOn
                                  ? (snapshot.data ==
                                          BluetoothDeviceState.connected)
                                      ? ThemePrimary.primaryColor
                                      : ThemePrimary.colorParentApp
                                  : Colors.grey),
                          onTap: () {
                            viewModel.onTapQRScanDeviceButton();
                          },
                          child: Center(
                              child: viewModel.isBluetoothOn
                                  ? (snapshot.data ==
                                          BluetoothDeviceState.connected)
                                      ? Icon(
                                          Icons.settings_remote,
                                          color: Colors.white,
                                          size: 25,
                                        )
                                      : CircleAvatar(
                                          radius: 13.0,
                                          backgroundImage: AssetImage(
                                              "assets/images/scan-device-signal.gif"),
                                          backgroundColor: Colors.transparent,
                                        )
                                  : Icon(
                                      Icons.bluetooth_disabled,
                                      color: Colors.white,
                                      size: 25,
                                    )),
                        );
                      },
                    )
                  : TS24Button(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: viewModel.isBluetoothOn
                              ? ThemePrimary.colorParentApp
                              : Colors.grey),
                      onTap: () {
                        viewModel.onTapQRScanDeviceButton();
                      },
                      child: Center(
                          child: viewModel.isBluetoothOn
                              ? CircleAvatar(
                                  radius: 13.0,
                                  backgroundImage: AssetImage(
                                      "assets/images/scan-device-signal.gif"),
                                  backgroundColor: Colors.transparent,
                                )
                              : Icon(
                                  Icons.bluetooth_disabled,
                                  color: Colors.white,
                                  size: 25,
                                )),
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
          top: false,
          bottom: true,
          left: false,
          right: false,
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
      return Stack(
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
      );
    }

    Widget __buildIconLocation() {
      return SizedBox(
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
                      (Platform.isAndroid || Platform.isFuchsia)
                          ? (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? Positioned(
                                  right: 0,
                                  top: 115,
                                  child: Container(
                                    height: 360,
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          right: 0,
                                          top: 10,
                                          child: __notice(),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 150,
                                          child: __navigateGoogleMap(),
                                        ),
                                        Positioned(
                                          top: 230,
                                          right: 0,
                                          child: __sosButton(),
                                        ),
//                                        Positioned(
//                                          top: 310,
//                                          right: 0,
//                                          child: __connectQrScanDevice(),
//                                        ),
                                        Positioned(
                                          right: 15,
                                          top: 310,
                                          child: __buildIconLocation(),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Positioned(
                                  right: 0,
                                  top: 75,
                                  child: Container(
                                    height: 325,
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          right: 0,
                                          top: 10,
                                          child: __notice(),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 85,
                                          child: __navigateGoogleMap(),
                                        ),
                                        Positioned(
                                          top: 150,
                                          right: 0,
                                          child: __sosButton(),
                                        ),
                                        Positioned(
                                          right: 15,
                                          top: 215,
                                          child: __buildIconLocation(),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                          : (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? Positioned(
                                  right: 0,
                                  top: 130,
                                  child: Container(
                                    height: 360,
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          right: 0,
                                          top: 10,
                                          child: __notice(),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 150,
                                          child: __navigateGoogleMap(),
                                        ),
                                        Positioned(
                                          top: 230,
                                          right: 0,
                                          child: __sosButton(),
                                        ),
//                                        Positioned(
//                                          top: 310,
//                                          right: 0,
//                                          child: __connectQrScanDevice(),
//                                        ),
                                        Positioned(
                                          right: 15,
                                          top: 310,
                                          child: __buildIconLocation(),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Positioned(
                                  right: 0,
                                  top: 65,
                                  child: Container(
                                    height: 325,
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          right: 0,
                                          top: 10,
                                          child: __notice(),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 85,
                                          child: __navigateGoogleMap(),
                                        ),
                                        Positioned(
                                          top: 150,
                                          right: 0,
                                          child: __sosButton(),
                                        ),
                                        Positioned(
                                          right: 15,
                                          top: 215,
                                          child: __buildIconLocation(),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                      __backButton(),
                      __finishButton(),
                      __report(),
                      __connectQrScanDevice(),
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
