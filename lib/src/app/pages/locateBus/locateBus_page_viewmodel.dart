import 'dart:async';

import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/service/index.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocateBusPageViewModel extends ViewModelBase {
  bool showGoolgeMap = true;
  bool showSpinner = false;
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController mapController;
  final LatLng center = const LatLng(10.777317, 106.677513);
  final Set<Marker> marker = <Marker>{};

  void onMapCreated(GoogleMapController controller) async {
    _mapController.complete(controller);
    mapController = await _mapController.future;
    //Get style map
    String _pathStyleMap =
        await Common.getJsonFile("assets/json/styleMap_uber.json");
    mapController.setMapStyle(_pathStyleMap);
    this.updateState();
    // Future.delayed(const Duration(milliseconds: 1000), () {
    //   showSpinner = false;
    //   this.updateState();
    // });
  }
}
