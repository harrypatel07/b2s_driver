import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/models-traccar/position.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/pages/locateBus/widgets/icon_marker_custom.dart';
import 'package:b2s_driver/src/app/service/common-service.dart';
import 'package:b2s_driver/src/app/service/googlemap-service.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryTripDetailMapViewModel extends ViewModelBase {
  // final Set<Marker> markers = {};
  final Set<Polyline> polyLines = {};
  LatLng center = const LatLng(10.777317, 106.677513);
  List<Positions> listPosition;
  List<RouteBus> listRouteBus;
  GoogleMapController mapController;
  GoogleMapService googleMapsServices = GoogleMapService();

  Map<PolylineId, Polyline> polyline = <PolylineId, Polyline>{};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  PolylineId selectedPolyline = PolylineId("Polyline01");

  void onCreated(GoogleMapController controller) async {
    mapController = controller;
    String _pathStyleMap =
        await Common.getJsonFile("assets/json/styleMap_uber.json");
    mapController.setMapStyle(_pathStyleMap);
    this.updateState();
    drawPolylineAndMarkers();
//    await animateMyLocation(animate: true);
    animateToCenterRoute();
  }

  void animateToCenterRoute() async {
    if (listPosition != null && listPosition.length > 0) {
      center = LatLng(listPosition[listPosition.length ~/ 2].latitude,
          listPosition[listPosition.length ~/ 2].longitude);
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: center, zoom: 12.0)));
      this.updateState();
    }
  }

  Future drawPolylineAndMarkers() async {
    if (listPosition != null && listPosition.length > 0) {
      polyline[selectedPolyline] = Polyline(
        polylineId: selectedPolyline,
        visible: true,
        color: ThemePrimary.primaryColor.withOpacity(0.5),
        width: 5,
        zIndex: 2,
        points: listPosition
            .map((route) => LatLng(route.latitude, route.longitude))
            .toList(),
      );
    }
    var i = 1;
    for (var item in listRouteBus) {
      await _addMarker(LatLng(item.lat, item.lng), item.routeName, i++);
    }
    this.updateState();
  }

  // onSend() async {
  //   for (int i = 0; i < listPosition.length - 1; i++) {
  //     googleMapsServices
  //         .getRouteCoordinates(
  //             LatLng(listPosition[i].latitude, listPosition[i].longitude),
  //             LatLng(
  //                 listPosition[i + 1].latitude, listPosition[i + 1].longitude))
  //         .then((route) {
  //       createRoute(route, i);
  //     });
  //   }
  //   for (int i = 0; i < listRouteBus.length; i++) {
  //     addMarker(LatLng(listRouteBus[i].lat, listRouteBus[i].lng),
  //         listRouteBus[i].routeName, i + 1);
  //   }
  //   this.updateState();
  // }

  Future<void> _addMarker(LatLng location, String address, int position) async {
    // markers.add(Marker(
    //     markerId: MarkerId(location.toString()),
    //     position: location,
    //     infoWindow: InfoWindow(title: address),
    //     icon: await iconMarkerCustomText(
    //       text: position.toString(),
    //       color: Colors.white,
    //       backgroundColor: ThemePrimary.primaryColor,
    //       strokeColor: Colors.white,
    //     )));

    markers[MarkerId(location.toString())] = Marker(
      markerId: MarkerId(location.toString()),
      position: location,
      infoWindow: InfoWindow(title: address),
      icon: await iconMarkerCustomText(
        text: position.toString(),
        color: Colors.white,
        backgroundColor: ThemePrimary.primaryColor,
        strokeColor: Colors.white,
      ),
    );

    //notifyListeners();
  }

  void createRoute(String encondedPoly, int id) {
    polyLines.add(Polyline(
        polylineId: PolylineId(id.toString()),
        width: 5,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: ThemePrimary.primaryColor));
    this.updateState();
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
    print(lList.toString());
    return lList;
  }

  onTapBackButton() {
    Navigator.pop(context);
  }
}
