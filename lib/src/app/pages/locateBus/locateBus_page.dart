import 'dart:ui' as prefix0;

import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/locateBus/emergency/emergency_page.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
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
    //viewModel.listenData();
    viewModel.onCreateDriverBusSessionReport();
    super.initState();
  }

  Widget _buildBody() {
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

    Widget __report() {
      final ___textStyle =
          TextStyle(fontSize: 16, color: ThemePrimary.primaryColor);
      final ___numberStyle = TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: ThemePrimary.primaryColor);
      return Positioned(
        top: 0,
        child: ClipRect(
          child: BackdropFilter(
            filter: prefix0.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 30, 15, 5),
              width: MediaQuery.of(context).size.width,
//              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Học sinh đăng ký",
                            textAlign: TextAlign.center,
                            style: ___textStyle,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Học sinh trên xe",
                            textAlign: TextAlign.center,
                            style: ___textStyle,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Học sinh báo nghỉ",
                            textAlign: TextAlign.center,
                            style: ___textStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                          child: Text(
                            viewModel.driverBusSession.totalChildrenRegistered
                                .toString(),
                            textAlign: TextAlign.center,
                            style: ___numberStyle,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                          child: Text(
                            viewModel.driverBusSession.totalChildrenInBus
                                .toString(),
                            textAlign: TextAlign.center,
                            style: ___numberStyle,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                          child: Text(
                            viewModel.driverBusSession.totalChildrenLeave
                                .toString(),
                            textAlign: TextAlign.center,
                            style: ___numberStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget __navigateGoogleMap() {
      return Positioned(
        bottom: MediaQuery.of(context).size.height / 2 - 70,
        right: 0,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20),
              decoration: new BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 1.0, // has the effect of softening the shadow
                      spreadRadius:
                          1.0, // has the effect of extending the shadow
                      offset: Offset(
                        -1.0, // horizontal, move right 10
                        -1.0, // vertical, move down 10
                      ),
                    )
                  ],
                  color: Colors.white54,
                  borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40))),
              width: 60,
              height: 60,
            ),
            Positioned(
              top: 4,
              left: 2,
              child: InkWell(
                onTap: () {
                  viewModel.onTapGoogleMaps();
                },
                child: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: ThemePrimary.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Transform.rotate(
                        angle: 3.14 / 4,
                        child: Icon(
                          Icons.navigation,
                          color: Colors.white,
                          size: 25,
                        ))),
              ),
            ),
          ],
        ),
      );
    }

    Widget __finishButton() {
      return Positioned(
        bottom: -40,
        right: MediaQuery.of(context).size.width / 2 - 50,
        child: InkWell(
          onTap: () {
            viewModel.onTapFinish();
          },
          child: Container(
            alignment: Alignment.topCenter,
            width: 100,
            height: 100,
            decoration: BoxDecoration(boxShadow: [
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
            ], shape: BoxShape.circle, color: ThemePrimary.primaryColor),
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
      );
    }

    Widget __sosButton() {
      return Positioned(
        bottom: MediaQuery.of(context).size.height / 2,
        right: 0,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20),
              decoration: new BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 1.0, // has the effect of softening the shadow
                      spreadRadius:
                          1.0, // has the effect of extending the shadow
                      offset: Offset(
                        -1.0, // horizontal, move right 10
                        -1.0, // vertical, move down 10
                      ),
                    )
                  ],
                  color: Colors.white54,
                  borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40))),
              width: 60,
              height: 60,
            ),
            Positioned(
              top: 4,
              left: 2,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, EmergencyPage.routeName);
                  print("On tab SOS");
                },
                child: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                    color: Colors.red[300],
                    shape: BoxShape.circle,
                  ),
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
        right: 10.0,
        bottom: MediaQuery.of(context).size.height / 2 - 120,
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

    return Stack(
      children: <Widget>[
        viewModel.showGoolgeMap ? __buildGoogleMap() : Container(),
        viewModel.showSpinner
            ? LoadingIndicator.progress(
                context: context, loading: true, position: Alignment.topCenter)
            : Container(),
        __report(),
        __sosButton(),
        __buildIconLocation(),
        __navigateGoogleMap(),
        __finishButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return MaterialApp(
              home: new Scaffold(
                body: Stack(
                  children: <Widget>[
                    _buildBody(),
//                    if(viewModel.listTimeLine!=null)_builBottomSheet()
                  ],
                ),
                //body: Container()
              ),
            );
          }),
    );
  }
}
