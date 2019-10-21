import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/pages/locateBus/emergency/emergency_page.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LocateBusPage extends StatefulWidget {
  static const String routeName = "/locateBus";
  @override
  _LocateBusPageState createState() => _LocateBusPageState();
}

class _LocateBusPageState extends State<LocateBusPage> {
  LocateBusPageViewModel viewModel;

  final double _initFabHeight = 100.0;
  double _fabHeight;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 120.0;

  ScrollController _sc = ScrollController();
  PanelController _pc = PanelController();
  bool disableScroll = true;

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fabHeight = _initFabHeight;
    _sc.addListener(() {
      // if (_pc.isPanelOpen()) {
      //   setState(() {
      //     disableScroll = _sc.offset <= 0;
      //   });
      // }
    });
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
      return Positioned(
        top: 0,
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 30, 15, 5),
          width: MediaQuery.of(context).size.width,
          color: Colors.white54,
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
                        style: TextStyle(fontSize: 16),
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
                        style: TextStyle(fontSize: 16),
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
                        style: TextStyle(fontSize: 16),
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
                        "20",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Text(
                        "10",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Text(
                        "02",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
                      spreadRadius: 1.0, // has the effect of extending the shadow
                      offset: Offset(
                        -1.0, // horizontal, move right 10
                        -1.0, // vertical, move down 10
                      ),
                    )
                  ],
                  color: Colors.white54,
                  //border: new Border.all(color: Colors.white, width: 2.0),
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
                onTap: (){
                  Navigator.pushNamed(context, EmergencyPage.routeName);
                  print("On tab SOS");
                },
                child: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  //margin: EdgeInsets.fromLTRB(0, 3, 10, 3),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text("SOS",textAlign: TextAlign.center,style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.w900),),
                ),
              ),
            ),
          ],
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
        __sosButton()
      ],
    );
  }

  Widget _buildPanel() {
    Widget __childrenCard() {
      return Stack(
        children: <Widget>[
          HomePageCardTimeLine(
            children: viewModel.childrenBus.child,
            isEnablePicked:
                viewModel.childrenBus.status.statusID == 0 ? true : false,
            status: viewModel.childrenBus.status,
            onTapPickUp: () {
              viewModel.onTapPickUp();
            },
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 15,
            top: 5,
            child: GestureDetector(
              // onTap: () {
              //   _pc.close();
              // },
              // onLongPress: () {
              //   _pc.close();
              // },
              onVerticalDragDown: (drag) {
                _pc.close();
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
        controller: _sc,
        physics: disableScroll
            ? NeverScrollableScrollPhysics()
            : ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            __childrenCard(),
          ],
        ));
  }

  Widget _buildIconLocation() {
    return Positioned(
      right: 20.0,
      bottom: _fabHeight,
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

  @override
  Widget build(BuildContext context) {
    TabsPageViewModel tabsPageViewModel = ViewModelProvider.of(context);
    viewModel = tabsPageViewModel.locateBusPageViewModel;
    _panelHeightOpen = MediaQuery.of(context).size.height * 2 / 3;
    return StatefulWrapper(
      onInit: () {},
      child: ViewModelProvider(
        viewmodel: viewModel,
        child: StreamBuilder<Object>(
            stream: viewModel.stream,
            builder: (context, snapshot) {
              return Stack(
                children: <Widget>[
                  SlidingUpPanel(
                    controller: _pc,
                    parallaxEnabled: true,
                    backdropEnabled: true,
                    parallaxOffset: .5,
                    maxHeight: _panelHeightOpen,
                    minHeight: _panelHeightClosed,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        topRight: Radius.circular(18.0)),
                    panel: _buildPanel(),
                    onPanelOpened: () {
                      setState(() {
                        disableScroll = false;
                      });
                    },
                    onPanelClosed: () {
                      setState(() {
                        disableScroll = true;
                      });
                    },
                    onPanelSlide: (double pos) => setState(() {
                      _fabHeight =
                          pos * (_panelHeightOpen - _panelHeightClosed) +
                              _initFabHeight;
                    }),
                    body: new Scaffold(
                      body: _buildBody(),
                      // body: Container()
                    ),
                  ),
                  _buildIconLocation()
                ],
              );
            }),
      ),
    );
  }
}
