import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/service/googlemap-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryTripDetailViewModel extends ViewModelBase {
  String urlMaps = "";
  HistoryTripDetailViewModel() {}
  List<Children> getListChildrenForTimeLine(
      DriverBusSession driverBusSession, int routeBusID) {
    List<Children> _listChildren = [];
    var _childrenRoute = ChildDrenRoute.getChilDrenRouteByRouteID(
        driverBusSession.childDrenRoute, routeBusID);
    if (_childrenRoute != null)
      _listChildren = Children.getChildrenByListID(
          driverBusSession.listChildren, _childrenRoute.listChildrenID);
    return _listChildren;
  }

  getUrlMaps(DriverBusSession driverBusSession) {
    if (urlMaps == "")
      urlMaps = GoogleMapService.getUrlImageFromMultiMarker(
        width: (MediaQuery.of(context).size.width.toInt() - 40) * 2,
        height: 170,
        listLatLng: driverBusSession.listRouteBus
            .map((route) => LatLng(route.lat, route.lng))
            .toList(),
      );
  }
}
