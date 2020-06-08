import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/historyDriver.dart';
import 'package:b2s_driver/src/app/models/itemCustomPopupMenu.dart';
import 'package:b2s_driver/src/app/pages/historyTripDetailPage/historyTrip_detail_page.dart';
import 'package:b2s_driver/src/app/service/googlemap-service.dart';
import 'package:b2s_driver/src/app/service/traccar-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class HistoryTripViewModel extends ViewModelBase {
  List<HistoryDriver> listHistoryDriverBusSession = List();
  List<CustomPopupMenu> choicesVehicle;
  CustomPopupMenu selectedVehicle;

  Driver driver = Driver();
  bool loadingMore = false;
  bool loadMoreDone = false;
  ScrollController controller = ScrollController();
  int _take = 50;
  int _skip = 0;
  HistoryTripViewModel() {
    choicesVehicle = driver.listVehicle
        .map((vehicle) => CustomPopupMenu(
            id: vehicle.id,
            title:
                (vehicle.licensePlate is bool || vehicle.licensePlate == null)
                    ? ''
                    : vehicle.licensePlate.toString()))
        .toList();
    controller.addListener(() {
      if (controller.offset == controller.position.maxScrollExtent &&
          !controller.position.outOfRange) onLoadMore();
    });
    selectedVehicle = CustomPopupMenu(
        id: driver.listVehicle[0].id,
        title: (driver.listVehicle[0].licensePlate is bool ||
                driver.listVehicle[0].licensePlate == null)
            ? ''
            : driver.listVehicle[0].licensePlate.toString());
    onLoad();
  }

  @override
  void dispose() {
    controller.dispose();
  }

  void onLoad() {
    loading = true;
    loadMoreDone = false;
    this.updateState();
    _take = 50;
    _skip = 0;
    listHistoryDriverBusSession = List();
    api.getHistoryDriver(take: _take, skip: _skip).then((list) {
      listHistoryDriverBusSession = list;
      _skip = _take;
      loading = false;
      _getImageHistory();
      this.updateState();
      // _getImageHistoryPositions();
    });
  }

  void onLoadMore() {
    if (loadMoreDone) return;
    loadingMore = true;
    this.updateState();
//    int countItemLoad = 0;
    api.getHistoryDriver(take: _take, skip: _skip).then((list) {
      if (list.length > 0) {
        // list.forEach((historyDriver) {
        //   countItemLoad += historyDriver.listHistory.length;
        // });
        // if (countItemLoad < _take) loadMoreDone = true;
        listHistoryDriverBusSession.addAll(list);
        _skip += _take;
        loadingMore = false;
        _getImageHistory();
      } else {
        loadingMore = false;
        loadMoreDone = true;
        this.updateState();
      }
      //  _getImageHistoryPositions();
      this.updateState();
    });
  }

  onChangeVehicle() {
    driver.vehicleId = selectedVehicle.id;
    driver.vehicleName = selectedVehicle.title;
    onLoad();
  }

  String datePrevious(String dateCurrent) {
    DateTime dateTime = DateTime.parse(dateCurrent);
    dateTime = dateTime.add(Duration(days: -1));
    return DateFormat('yyyy-MM-dd').format(dateTime).toString();
  }

  onTapHistory(DriverBusSession driverBusSession) {
    Navigator.pushNamed(context, HistoryTripDetailPage.routeName,
        arguments: driverBusSession);
  }

  // Lấy hình các điểm đã đi trong chuyến
  _getImageHistory() {
    for (var i = 0; i < listHistoryDriverBusSession.length; i++) {
      var historyDriverBusSession = listHistoryDriverBusSession[i];
      for (var j = 0; j < historyDriverBusSession.listHistory.length; j++) {
        var driverBusSession = historyDriverBusSession.listHistory[j];
        historyDriverBusSession.listUrlHistoryPositions[j] =
            GoogleMapService.getUrlImageFromMultiMarker(
          width: (MediaQuery.of(context).size.width.toInt() - 40) * 2,
          height: 170 * 2,
          listLatLng: driverBusSession.listRouteBus
              .map((route) => LatLng(route.lat, route.lng))
              .toList(),
        );
        // TracCarService.getPositions(
        //         sessionId: driverBusSession.sessionID,
        //         date: DateFormat('yyyy-MM-dd').format(
        //             DateTime.parse(historyDriverBusSession.transportDate)),
        //         uniqueId: driver.vehicleName)
        //     .then((data) {
        //   if (data.length > 0) {
        //     historyDriverBusSession.listUrlHistoryPositions[j] =
        //         GoogleMapService.getUrlImageFromMultiMarker(
        //       width: (MediaQuery.of(context).size.width.toInt() - 40) * 2,
        //       height: 170 * 2,
        //       listLatLng: driverBusSession.listRouteBus
        //           .map((route) => LatLng(route.lat, route.lng))
        //           .toList(),
        //       listPosition: data
        //           .map((route) => LatLng(route.latitude, route.longitude))
        //           .toList(),
        //     );
        //     this.updateState();
        //   }
        // });
      }
    }
  }
}
