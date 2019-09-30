import 'dart:async';

import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocateBusPage extends StatefulWidget {
  static const String routeName = "/locateBus";
  @override
  _LocateBusPageState createState() => _LocateBusPageState();
}

class _LocateBusPageState extends State<LocateBusPage> {
  LocateBusPageViewModel viewModel;
  @override
  void initState() {
    // Future.delayed(const Duration(milliseconds: 2000), () {
    //   setState(() {
    //     _showGoolgeMap = true;
    //     _marker.add(Marker(
    //       markerId: MarkerId("1"),
    //       position: LatLng(10.777317, 106.677513),
    //     ));
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabsPageViewModel tabsPageViewModel = ViewModelProvider.of(context);
    viewModel = tabsPageViewModel.locateBusPageViewModel;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return new Scaffold(
              body: _buildGoogleMap(),
              // body: Container()
            );
          }),
    );
  }

  Widget _buildGoogleMap() {
    return Stack(
      children: <Widget>[
        viewModel.showGoolgeMap
            ? GoogleMap(
                onMapCreated: viewModel.onMapCreated,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                compassEnabled: true,
                markers: viewModel.marker,
                initialCameraPosition: CameraPosition(
                  target: viewModel.center,
                  zoom: 15.0,
                ),
              )
            : Container(),
        viewModel.showSpinner
            ? LoadingIndicator.progress(
                context: context, loading: true, position: Alignment.topCenter)
            : Container()
      ],
    );
  }
}
