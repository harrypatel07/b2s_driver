import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/home/profile_children/profile_children.dart';
import 'package:b2s_driver/src/app/service/common-service.dart';
import 'package:b2s_driver/src/app/service/googlemap-service.dart';
import 'package:b2s_driver/src/app/service/traccar-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class HistoryTripDetailViewModel extends ViewModelBase {
  String urlMaps = "";
  ScrollController scrollController;
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
    urlMaps = GoogleMapService.getUrlImageFromMultiMarker(
      width: (MediaQuery.of(context).size.width.toInt()) * 2,
      height: 200 * 2,
      listLatLng: driverBusSession.listRouteBus
          .map((route) => LatLng(route.lat, route.lng))
          .toList(),
    );
    TracCarService.getPositions(
        sessionId: driverBusSession.sessionID,
        date: DateFormat('yyyy-MM-dd').format(
            DateTime.parse(driverBusSession.listRouteBus[0].date)),
        uniqueId: Driver().vehicleName)
        .then((data) {
      if (data.length > 0) {
        urlMaps =
            GoogleMapService.getUrlImageFromMultiMarker(
              width: (MediaQuery.of(context).size.width.toInt()) * 2,
              height: 200 * 2,
              listLatLng: driverBusSession.listRouteBus
                  .map((route) => LatLng(route.lat, route.lng))
                  .toList(),
              listPosition: data
                  .map((route) => LatLng(route.latitude, route.longitude))
                  .toList(),
            );
        this.updateState();
      }
    });
//    if (urlMaps == "")
//      urlMaps = GoogleMapService.getUrlImageFromMultiMarker(
//          width: (MediaQuery.of(context).size.width.toInt() - 40) * 2,
//          height: 170,
//          listLatLng: driverBusSession.listRouteBus
//              .map((route) => LatLng(route.lat, route.lng))
//              .toList(),
//          listPosition: driverBusSession.listRouteBus
//              .map((route) => LatLng(route.lat, route.lng))
//              .toList());
  }

  String getDifferenceTime(String timeEstimate, String timeReal) {
    String result = '';
    if (timeReal == '') return '';
    DateFormat dateFormat = new DateFormat.Hm();
    DateTime now = DateTime.now();
    DateTime estimate =
        dateFormat.parse(Common.removeMiliSecond(timeEstimate.toString()));
    estimate = new DateTime(
        now.year, now.month, now.day, estimate.hour, estimate.minute);
    DateTime real =
        dateFormat.parse(Common.removeMiliSecond(timeReal.toString()));
    real = new DateTime(now.year, now.month, now.day, real.hour, real.minute);

    String hour = '';
    String minute = '';
    int h = estimate.difference(real).inHours.abs();
    if (h > 0) hour = '${h}h';
    int m = estimate.difference(real).inMinutes.abs() -
        estimate.difference(real).inHours.abs() * 60;
    if (m > 0) minute = '${m}m';
    if (h == 0 && m == 0) return '0m';
    if (real.isBefore(estimate))
      result = 'sớm $hour $minute';
    else
      result = 'muộn $hour $minute';
    return result;
  }

  onTapChildren(Children children, String heroTag) {
    Navigator.pushNamed(context, ProfileChildrenPage.routeName,
        arguments: ProfileChildrenArgs(children: children, heroTag: heroTag));
  }
}
