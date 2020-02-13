import 'dart:async';
import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/models/bottom_sheet_viewmodel_abstract.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/pages/bottomSheet/bottom_sheet_custom.dart';
import 'package:b2s_driver/src/app/pages/home/home_page.dart';
import 'package:b2s_driver/src/app/pages/locateBus/bottomSheetListRoute/bottomSheet_list_route.dart';
import 'package:b2s_driver/src/app/pages/locateBus/connectQRscanDevices/connect_qrscan_devices_page.dart';
import 'package:b2s_driver/src/app/pages/locateBus/emergency/emergency_page.dart';
import 'package:b2s_driver/src/app/pages/locateBus/widgets/icon_marker_custom.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page.dart';
import 'package:b2s_driver/src/app/service/bluetooh-barcode-service.dart';
import 'package:b2s_driver/src/app/service/index.dart';
import 'package:b2s_driver/src/app/service/text-to-speech-service.dart';
import 'package:b2s_driver/src/app/service/traccar-service.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocateBusPageViewModel extends BottomSheetViewModelBase {
  BluetoothBarcodeService barcodeService = BluetoothBarcodeService();
  DriverBusSession driverBusSessionInput;
  bool showGoolgeMap = true;
  bool showSpinner = false;
  bool myLocationEnabled = false;
  GoogleMapController mapController;
  LatLng center = const LatLng(10.777317, 106.677513);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<PolylineId, Polyline> polyline = <PolylineId, Polyline>{};
  Location location = Location();
  //For ios location
  Geolocator geolocator = Geolocator();
  //List<Children> listChildrenPaidTicket;
  StreamSubscription streamLocation;
  int pointNext = 0;
  //Tạo list routeBus cho thông báo khi xe sắp đến.
  Map _listRouteBusPushed = Map();
  BluetoothDevice bluetoothDeviceConnected;
  StreamSubscription streamQrCode;
  StreamSubscription streamBluetoothAvailable;
  StreamSubscription streamConnectedDevice;
  bool isBluetoothOn = false;
  LocateBusPageViewModel() {
    listenBluetoothAvailable();
    listenBluetoothDeviceConnected();
  }

  //Tracking my location
  bool _trackingMyLoc = false;
  @override
  dispose() {
    //  if (streamCloud != null) streamCloud.cancel();
    if (streamQrCode != null) streamQrCode.cancel();
    if (streamLocation != null) streamLocation.cancel();
    if (streamBluetoothAvailable != null) streamBluetoothAvailable.cancel();
    if (streamConnectedDevice != null) streamConnectedDevice.cancel();
    barcodeService.onDispose();
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
    await animateMyLocation(animate: false);
    await listenLocation();
    this.increasePointNextPick();
    // animateThePoint(0);
    initMarkers();
  }

  Future animateMyLocation({bool animate = true}) async {
    var myLoc = await location.getLocation();
    if (animate) {
      _trackingMyLoc = true;
      center = LatLng(myLoc.latitude, myLoc.longitude);
      _animateCamera(center, bearing: 120, tilt: 90);
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
  }

  void animateThePoint(int point, [bool speak = false]) async {
    var firstRoute = driverBusSession.listRouteBus[point];
    center = LatLng(firstRoute.lat, firstRoute.lng);
    if (speak)
      TextToSpeechService.speak(
          "Địa chỉ điểm số ${point + 1} là ${firstRoute.routeName}");
    if (mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: center, zoom: 17.0)));
      this.updateState();
    }
  }

  Future initMarkers() async {
    markers.clear();
    for (int i = 0; i < driverBusSession.listRouteBus.length; i++) {
      var route = driverBusSession.listRouteBus[i];
      if (!route.status) {
        markers[MarkerId(route.id.toString())] = Marker(
            markerId: MarkerId(route.id.toString()),
            consumeTapEvents: true,
            position: LatLng(route.lat, route.lng),
            icon: await iconMarkerCustomText(
              text: (i + 1).toString(),
              color: Colors.white,
              backgroundColor: ThemePrimary.primaryColor,
              strokeColor: Colors.white,
            ),
            onTap: () {
              onTapMaker(route, i + 1);
            });
      }
    }
    this.updateState();
  }

  onTapMaker(RouteBus _route, int _pos) {
    _trackingMyLoc = false;
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
//            print(e);
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
    // if (driverBusSession.totalChildrenPick ==
    //         driverBusSession.totalChildrenDrop &&
    //     (driverBusSession.totalChildrenPick +
    //             driverBusSession.totalChildrenLeave) ==
    //         driverBusSession.totalChildrenRegistered) {
    //   driverBusSession.status = true;
    //   showSpinner = true;
    //   this.updateState();
    //   //Kiểm tra attendant đã hoàn thành chuyến
    //   List<int> listIdPicking =
    //       driverBusSession.childDrenStatus.map((item) => item.id).toList();
    //   bool checkFinished =
    //       await checkSessionFinishedByAnotherRole(listIdPicking);
    //   showSpinner = false;
    //   this.updateState();
    //   if (!checkFinished) {
    //     String barcode = await BarCodeService.scan();
    //     print(barcode);
    //     if (barcode != null) {
    //       if (checkTicketCodeWhenTapFinished(barcode)) {
    //         List<int> listIdPicking = driverBusSession.childDrenStatus
    //             .map((item) => item.id)
    //             .toList();
    //         api.updateUserRoleFinishedBusSession(listIdPicking, 0);
    //         driverBusSession.clearLocal();
    //       } else
    //         return false;
    //     } else
    //       return false;
    //   } else
    //     driverBusSession.clearLocal();
    //   Navigator.pushReplacementNamed(context, TabsPage.routeName,
    //       arguments: TabsArgument(routeChildName: HomePage.routeName));
    // } else
    //   LoadingDialog.showMsgDialog(context,
    //       'Chưa hoàn thành tất cả các trạm, không thể kết thúc chuyến.');
    Get.offAllNamed(TabsPage.routeName, (route) => false,
        arguments: TabsArgument(routeChildName: HomePage.routeName));
  }

  listenLocation() async {
    await TracCarService.initDeviceTracCar();
    if (streamLocation != null) streamLocation.cancel();
    streamLocation = geolocator.getPositionStream().listen((onData) {
      // final _marker = markers[MarkerId("location")];
      // markers[MarkerId("location")] = _marker.copyWith(
      //     rotationParam: onData.heading,
      //     positionParam: LatLng(onData.latitude, onData.longitude));
      if (_trackingMyLoc) {
        _animateCamera(LatLng(onData.latitude, onData.longitude),
            bearing: onData.heading, tilt: 90);
      }
      Driver driver = Driver();
      Future.delayed(Duration(seconds: 20), () {
        api.updateCoordinateVehicle(driver.vehicleId, onData);
      });
      checkBusLocationWithRoute(LatLng(onData.latitude, onData.longitude));
      TracCarService.updateDeviceTracCar(onData, driverBusSession.sessionID);
    });
    // this.updateState();
  }

  _animateCamera(LatLng latlng, {double bearing = 0.0, double tilt = 0.0}) {
    if (mapController != null)
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: bearing, tilt: tilt, target: latlng, zoom: 16.5)));
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
        // if (result && driverBusSession.listRouteBus.length > pos) {
        //   animateThePoint(pos, true);
        // }
        if (result) {
          initMarkers();
          increasePointNextPick();
          this.updateState();
        }
      } catch (e) {
//        print(e);
      }
      this.updateState();
    });
    animateThePoint(pos - 1);
  }

  void showBottomSheetListRoute() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ct) {
        return BottomSheetListRoute(
          arguments: BottomSheetCustomArgs(viewModel: this),
        );
      },
    ).then((position) {
      try {
        if (position != null) {
          _trackingMyLoc = false;
          pointNext = position;
          animateThePoint(position - 1, true);
        }
//        this.updateState();
//        onTapMaker(driverBusSession.listRouteBus[position - 1], position);
      } catch (e) {
//        print(e);
      }
    });
//        .then((result) {
//      try {
//        if (result && driverBusSession.listRouteBus.length > pos) {
//          animateThePoint(pos);
//        }
//        if (result) initMarkers();
//      } catch (e) {
//        print(e);
//      }
//      this.updateState();
//    });
//    animateThePoint(pos - 1);
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
                    TextToSpeechService.speak('Xe đã đến điểm số ${i + 1}');
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
                        notification: "Xe sắp đến trong vòng 5 phút");
                  });
                  TextToSpeechService.speak(
                      "Xe sắp đến điểm số ${i + 1} trong vòng 5 phút.");
                }
                api.postNotificationBusIsComing(listChildren, "5");
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

  showNotifyCantBack() {
    LoadingDialog().showMsgDialogWithCloseButton(context,
        "Chuyến xe vẫn chưa hoàn thành, bạn không thể thực hiện thao tác này.");
  }

  onTapBackButton() {
    var listCheck = driverBusSession.childDrenStatus
        .where((status) => status.statusID != 0)
        .toList();
    if (listCheck.length == 0 || listCheck == null) {
      driverBusSession.clearLocal();
      if (Navigator.canPop(context))
        Navigator.pop(context);
      else
        Navigator.pushReplacementNamed(context, TabsPage.routeName,
            arguments: TabsArgument(routeChildName: HomePage.routeName));
    } else
      showNotifyCantBack();
  }

  List<Children> getListChildrenByStatusID(int statusID) {
    return driverBusSession.listChildren
        .where((children) => (driverBusSession.childDrenStatus
                .where((status) =>
                    status.childrenID == children.id &&
                    status.statusID == statusID)
                .toList()
                .length >
            0))
        .toList();
  }

  onTapNoticeContent() {
    if (pointNext != -1)
      onTapMaker(driverBusSession.listRouteBus[pointNext - 1], pointNext);
  }

  increasePointNextPick() {
    _trackingMyLoc = false;
    if (pointNext < driverBusSession.listRouteBus.length &&
        !driverBusSession.listRouteBus[pointNext].status &&
        !driverBusSession
            .listRouteBus[driverBusSession.listRouteBus.length - 1].status) {
      pointNext++;
    } else
      pointNext = getPointNextPick();
    if (pointNext != -1)
      animateThePoint(pointNext - 1, true);
    else {
      TextToSpeechService.speak(
          'Xin vui lòng bấm kết thúc để hoàn thành chuyến đi.');
    }
  }

  int getPointNextPick() {
    int result = -1;
    for (int i = 0; i < driverBusSession.listRouteBus.length; i++)
      if (driverBusSession.listRouteBus[i].status == false) {
        result = i + 1;
        if (result != pointNext) break;
      }
    return result;
  }

  String getAddressPointNext() {
    return (pointNext > 0)
        ? driverBusSession.listRouteBus[pointNext - 1].routeName
        : '';
  }

  int getCountChildrenPickPointNext() {
    RouteBus routeBus = driverBusSession.listRouteBus
        .firstWhere((routeBus) => routeBus.status == false);
    var listChildDrenStatus = driverBusSession.childDrenStatus
        .where((status) => status.routeBusID == routeBus.id)
        .toList();
    int countChildPick = listChildDrenStatus
        .where((childDrenStatus) =>
            childDrenStatus.statusID != 3 && childDrenStatus.typePickDrop == 0)
        .toList()
        .length;
    return countChildPick;
  }

  int getCountChildrenDropPointNext() {
    RouteBus routeBus = driverBusSession.listRouteBus
        .firstWhere((routeBus) => routeBus.status == false);
    var listChildDrenStatus = driverBusSession.childDrenStatus
        .where((status) => status.routeBusID == routeBus.id)
        .toList();
    int countChildDrop = listChildDrenStatus
        .where((childDrenStatus) =>
            childDrenStatus.statusID != 3 && childDrenStatus.typePickDrop == 1)
        .toList()
        .length;
    return countChildDrop;
  }

  RouteBus getRouteBusPointNext() {
    return driverBusSession.listRouteBus
        .firstWhere((routeBus) => routeBus.status == false);
  }

  int countChildPick() {
    return (pointNext > 0)
        ? driverBusSession.childDrenStatus
            .where((childDrenStatus) =>
                childDrenStatus.statusID != 3 &&
                driverBusSession.listRouteBus[pointNext - 1].id ==
                    childDrenStatus.routeBusID &&
                childDrenStatus.typePickDrop == 0)
            .toList()
            .length
        : 0;
  }

  int countChildDrop() {
    return (pointNext > 0)
        ? driverBusSession.childDrenStatus
            .where((childDrenStatus) =>
                childDrenStatus.statusID != 3 &&
                driverBusSession.listRouteBus[pointNext - 1].id ==
                    childDrenStatus.routeBusID &&
                childDrenStatus.typePickDrop == 1)
            .toList()
            .length
        : 0;
  }

  listenBluetoothAvailable() {
    if (streamBluetoothAvailable != null) streamBluetoothAvailable.cancel();
    streamBluetoothAvailable =
        barcodeService.checkBluetoothAvaiable().listen((onData) {
      if (onData != isBluetoothOn) {
        isBluetoothOn = onData;
        if (!onData) {
          ToastController.show(
              context: context,
              message:
                  "Bluetooth chưa bật hoặc thiết bị không có chức năng bluetooth.",
              duration: Duration(seconds: 2));
        }
        this.updateState();
      }
    });
  }

  listenBluetoothDeviceConnected() {
    if (streamConnectedDevice != null) streamConnectedDevice.cancel();
    streamConnectedDevice =
        barcodeService.getConnectedDevice().listen((onData) {
      if ((this.bluetoothDeviceConnected == null ||
              this.bluetoothDeviceConnected != onData) &&
          onData != null) {
        this.bluetoothDeviceConnected = onData;
        this.updateState();
        listenQrCode(this.bluetoothDeviceConnected);
      }
    });
//    barcodeService.getConnectedDevice().then((bluetoothDevice){
//      if(bluetoothDevice != null)
//        listenQrCode(bluetoothDevice);
//    });
  }

  listenQrCode(BluetoothDevice bluetoothDevice) {
    if (streamQrCode != null) streamQrCode.cancel();
    streamQrCode = barcodeService
        .listenDataQrCode(device: this.bluetoothDeviceConnected)
        .listen((onData) {
      if (onData.length > 0) listenQRcodeDevice(onData);
      print(onData);
    });
  }

  onTapQRScanDeviceButton() {
    Navigator.pushNamed(context, ConnectQRScanDevicesPage.routeName,
            arguments: this.bluetoothDeviceConnected)
        .then((bluetoothDevice) {
      listenBluetoothAvailable();
      if (bluetoothDevice != null) {
        this.bluetoothDeviceConnected = bluetoothDevice;
        this.updateState();
        listenQrCode(bluetoothDevice);
      } else
        this.updateState();
    });
  }
}
