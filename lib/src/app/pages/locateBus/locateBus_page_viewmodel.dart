import 'dart:async';
import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/models/bottom_sheet_viewmodel_abstract.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/pages/bottomSheet/bottom_sheet_custom.dart';
import 'package:b2s_driver/src/app/pages/home/home_page.dart';
import 'package:b2s_driver/src/app/pages/locateBus/emergency/emergency_page.dart';
import 'package:b2s_driver/src/app/pages/locateBus/widgets/icon_marker_custom.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page.dart';
import 'package:b2s_driver/src/app/service/index.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocateBusPageViewModel extends BottomSheetViewModelBase {
  bool showGoolgeMap = true;
  bool showSpinner = false;
  bool myLocationEnabled = false;
  GoogleMapController mapController;
  LatLng center = const LatLng(10.777317, 106.677513);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<PolylineId, Polyline> polyline = <PolylineId, Polyline>{};
  Location location = Location();
  //List<Children> listChildrenPaidTicket;
  StreamSubscription streamLocation;

  //Tạo list routeBus cho thông báo khi xe sắp đến.
  Map _listRouteBusPushed = Map();
  LocateBusPageViewModel();

  @override
  dispose() {
    //  if (streamCloud != null) streamCloud.cancel();
    if (streamLocation != null) streamLocation.cancel();
    super.dispose();
  }

  void onMapCreated(GoogleMapController controller) async {
    // _mapController.complete(controller);
    mapController = controller;
    //Get style map
    String _pathStyleMap =
        await Common.getJsonFile("assets/json/styleMap_uber.json");
    mapController.setMapStyle(_pathStyleMap);

    this.updateState();
    animateMyLocation(animate: false);
    animateThePoint(0);
    initMarkers();
  }

  void animateMyLocation({bool animate = true}) async {
    var myLoc = await location.getLocation();
    if (animate) {
      center = LatLng(myLoc.latitude, myLoc.longitude);
      _animateCamera(center);
    }
    myLocationEnabled = true;
//    childrenBus.status = StatusBus.list[0];
//    final iconMy = await GoogleMapService.getMarkerIcon(
//        'assets/images/icon_bus.png',
//        width: 50);
//    markers[MarkerId("location")] = Marker(
//      markerId: MarkerId("location"),
//      position: LatLng(myLoc.latitude, myLoc.longitude),
//      rotation: myLoc.heading,
//      icon: iconMy,
//    );
    if (!animate) {
      if (streamLocation != null) streamLocation.cancel();
      streamLocation = location.onLocationChanged().listen((onData) {
        // final _marker = markers[MarkerId("location")];
        // markers[MarkerId("location")] = _marker.copyWith(
        //     rotationParam: onData.heading,
        //     positionParam: LatLng(onData.latitude, onData.longitude));
        Driver driver = Driver();
        api.updateCoordinateVehicle(driver.vehicleId, onData);
        checkBusLocationWithRoute(LatLng(onData.latitude, onData.longitude));
      });
      this.updateState();
    }
  }

  void animateThePoint(int point) async {
    var firstRoute = driverBusSession.listRouteBus[point];
    center = LatLng(firstRoute.lat, firstRoute.lng);
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: center, zoom: 13.0)));
    this.updateState();
  }

  Future initMarkers() async {
    markers.clear();
    for (int i = 0; i < driverBusSession.listRouteBus.length; i++) {
      var route = driverBusSession.listRouteBus[i];
      markers[MarkerId(route.id.toString())] = Marker(
          markerId: MarkerId(route.id.toString()),
          consumeTapEvents: true,
          position: LatLng(route.lat, route.lng),
          icon: await iconMarkerCustomText(
            text: (i + 1).toString(),
            color: route.status ? Colors.black.withAlpha(200) : Colors.white,
            backgroundColor: route.status
                ? ThemePrimary.primaryColor.withAlpha(50)
                : ThemePrimary.primaryColor,
            strokeColor:
                route.status ? Colors.black.withAlpha(200) : Colors.white,
          ),
          onTap: () {
            onTapMaker(route, i + 1);
          });
    }
    this.updateState();
  }

  onTapMaker(RouteBus _route, int _pos) {
    this.position = _pos;
    this.routeBus = _route;
    if (_pos >= 2) {
      if (countRouteBusNotFinishPrev(_pos) == 0)
        showBottomSheet(_pos);
      else {
        LoadingDialog()
            .showMsgDialogWithButton(context, getTextPopupConfirm(_pos))
            .then((result) {
          try {
            if (result) showBottomSheet(_pos);
          } catch (e) {
            print(e);
          }
        });
      }
    } else
      showBottomSheet(_pos);
  }

  int getCountChildrenByStatus() {
    return driverBusSession.listChildren.length;
  }

  int getCountChildrenByStatusBusId(statusBusId) {
    int sum = 0;
    driverBusSession.listChildren.forEach((child) {
      List<ChildDrenStatus> checkConstraint = driverBusSession.childDrenStatus
          .where((status) =>
              status.childrenID == child.id && status.statusID == statusBusId)
          .toList();
      if (checkConstraint.length > 0) sum++;
    });
    return sum;
  }

  onTapGoogleMaps() {
    List<LatLng> listLatLng = driverBusSession.listRouteBus
        .map((routeBus) => LatLng(routeBus.lat, routeBus.lng))
        .toList();
    location.getLocation().then((location) {
      listLatLng.insert(0, LatLng(location.latitude, location.longitude));
      GoogleMapService.navigateMultiStepToGoogleMap(listLatLng);
    });
  }

  onTapFinish() async {
    if (driverBusSession.totalChildrenPick ==
            driverBusSession.totalChildrenDrop &&
        (driverBusSession.totalChildrenPick +
                driverBusSession.totalChildrenLeave) ==
            driverBusSession.totalChildrenRegistered) {
      driverBusSession.status = true;
      String barcode = await BarCodeService.scan();
      print(barcode);
      if (barcode != null) {
        driverBusSession.clearLocal();
        Navigator.pushReplacementNamed(context, TabsPage.routeName,
            arguments: TabsArgument(routeChildName: HomePage.routeName));
      }
    } else
      LoadingDialog.showMsgDialog(context,
          'Chưa hoàn thành tất cả các trạm, không thể kết thúc chuyến.');
  }

  // listenData() async {
  //   if (streamCloud != null) streamCloud.cancel();
  //   streamCloud = await cloudService.busSession
  //       .listenBusSessionForDriver(driverBusSession, () {
  //     onCreateDriverBusSessionReport();
  //     this.updateState();
  //   });
  // }

  _animateCamera(LatLng latlng) {
    if (mapController != null)
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latlng, zoom: 14.0)));
  }

  @override
  void showBottomSheet(int pos) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return BottomSheetCustom(
              arguments: BottomSheetCustomArgs(viewModel: this));
        }).then((result) {
      try {
        if (result && driverBusSession.listRouteBus.length > pos) {
          animateThePoint(pos);
        }
        if (result) initMarkers();
      } catch (e) {
        print(e);
      }
    });
    animateThePoint(pos - 1);
  }

//Kiểm tra vị trí xe và khoảng cách các route
  checkBusLocationWithRoute(LatLng bus) {
    double distance = 500;
    if (driverBusSession.type == 0)
      for (var i = 0; i < driverBusSession.listRouteBus.length; i++) {
        var route = driverBusSession.listRouteBus[i];
        //Kiểm tra khoảng cách 500 m
        var resultNear = GoogleMapService.checkTwoPointCloserDistance(
            bus, LatLng(route.lat, route.lng), distance);
        if (resultNear) {
          //Lấy list children id
          var listChildrenId =
              ChildDrenStatus.getListChildrenIdByTypeAndRouteBusId(
                  driverBusSession.childDrenStatus, 0, route.id);
          if (listChildrenId.length > 0) {
            var listChildren = Children.getChildrenByListID(
                driverBusSession.listChildren, listChildrenId);

            //Kiểm tra xe đã đến
            var resultCome = GoogleMapService.checkTwoPointCloserDistance(
                bus, LatLng(route.lat, route.lng), 50);
            if (resultCome) {
              if (_listRouteBusPushed.containsKey(route.id)) {
                if (_listRouteBusPushed[route.id] == distance) {
                  _listRouteBusPushed[route.id] = 0;
                  var listChildrenStatus =
                      ChildDrenStatus.getListChildrenStatusByTypeAndRouteBusId(
                          driverBusSession.childDrenStatus, 0, route.id);
                  if (listChildrenStatus.length > 0) {
                    listChildrenStatus.forEach((childrenStatus) {
                      cloudSerivce.busSession
                          .updateBusSessionFromChildrenStatus(childrenStatus,
                              notification:
                                  "Xe đã đến.Học sinh nhanh chóng ra xe");
                    });
                  }
                  api.postNotificationBusIsComing(listChildren, "",
                      isCome: true);
                }
              }
            } else {
              if (!_listRouteBusPushed.containsKey(route.id)) {
                _listRouteBusPushed[route.id] = distance;
                var listChildrenStatus =
                    ChildDrenStatus.getListChildrenStatusByTypeAndRouteBusId(
                        driverBusSession.childDrenStatus, 0, route.id);
                if (listChildrenStatus.length > 0) {
                  listChildrenStatus.forEach((childrenStatus) {
                    cloudSerivce.busSession.updateBusSessionFromChildrenStatus(
                        childrenStatus,
                        notification: "Xe sắp đến trong phòng 5 phút");
                  });
                }
                api.postNotificationBusIsComing(listChildren, "5 phút");
              }
            }
          }
        }
      }
  }

  onTapSOS() {
    Navigator.pushNamed(context, EmergencyPage.routeName,
        arguments: driverBusSession);
    print("On tab SOS");
  }
}
