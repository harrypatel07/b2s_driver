import 'package:b2s_driver/src/app/core/baseViewModel.dart';
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

    return Stack(
      children: <Widget>[
        viewModel.showGoolgeMap ? __buildGoogleMap() : Container(),
        viewModel.showSpinner
            ? LoadingIndicator.progress(
                context: context, loading: true, position: Alignment.topCenter)
            : Container()
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
