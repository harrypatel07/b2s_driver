import 'dart:math';

import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/historyDriver.dart';
import 'package:b2s_driver/src/app/models/itemCustomPopupMenu.dart';
import 'package:b2s_driver/src/app/pages/historyTripDetailPage/historyTrip_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class HistoryTripViewModel extends ViewModelBase {
  List<HistoryDriver> listHistoryDriverBusSession = List();
  List<CustomPopupMenu> choicesVehicle;
  CustomPopupMenu selectedVehicle;

  Driver driver = Driver();
  bool loadingMore = false;
  ScrollController controller = ScrollController();
  int _take = 10;
  int _skip = 0;
  HistoryTripViewModel() {
    choicesVehicle = driver.listVehicle
        .map((vehicle) => CustomPopupMenu(id: vehicle.id, title: vehicle.licensePlate))
        .toList();
    controller.addListener(() {
      if (controller.offset == controller.position.maxScrollExtent &&
          !controller.position.outOfRange) onLoadMore();
    });
    selectedVehicle = CustomPopupMenu(
        id: driver.listVehicle[0].id,
        title: driver.listVehicle[0].licensePlate,
        subTitle: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    onLoad();
  }
  void onLoad() {
    loading = true;
    this.updateState();
    _take = 10;
    _skip = 0;
    listHistoryDriverBusSession = List();
    api.getHistoryDriver(take: _take, skip: _skip).then((list) {
      list.forEach((historyDriver) {
        listHistoryDriverBusSession.add(historyDriver);
        _skip += historyDriver.listHistory.length;
      });
      loading = false;
      this.updateState();
    });
  }

  void onLoadMore() {
    loadingMore = true;
    this.updateState();
    api.getHistoryDriver(take: _take, skip: _skip).then((list) {
      list.forEach((historyDriver) {
        listHistoryDriverBusSession.add(historyDriver);
        _skip += historyDriver.listHistory.length;
      });
      loadingMore = false;
      this.updateState();
    });
  }

  onChangeVehicle() {
    driver.vehicleId = selectedVehicle.id;
    driver.vehicleName = selectedVehicle.title;
    onLoad();
  }

//  onLoad(int number, int countDay){
//    loading = true;
//    dateTimeCurrent =
//        DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
//    dateTimePrevious = datePrevious(dateTimeCurrent);
//    listDriverBusSession = List();
//    _onLoading(number, countDay);
//  }
//  _onLoading(int number, int countDay) {
//    if (countDay <= 0) {
//      listDriverBusSession.addAll(listDriverBusSessionLoadMore);
//      listDriverBusSessionLoadMore = List();
//      loading = false;
//      this.updateState();
//      return;
//    }
//    api
//        .getListDriverBusSession(
//            vehicleId: driver.vehicleId,
//            driverId: driver.id,
//            date: dateTimePrevious)
//        .then((value) {
//      if (value != null && value.length > 0)
//        value.forEach((item) {
//          listDriverBusSessionLoadMore.add(item);
//          number--;
//        });
//      else {
//        countDay--;
//      }
//      dateTimeCurrent = dateTimePrevious;
//      dateTimePrevious = datePrevious(dateTimeCurrent);
//      if (number > 0)
//        _onLoading(number, countDay);
//      else {
//        listDriverBusSession.addAll(listDriverBusSessionLoadMore);
//        listDriverBusSessionLoadMore = List();
//        loading = false;
//      }
//      this.updateState();
//    });
//    this.updateState();
//  }
//
//  ///number : số item cần load
//  ///countDate : phạm vi lấy dữ liệu trong vòng n ngày.
//  onLoadMore(int number, int countDay) {
//    if (countDay <= 0) {
//        listDriverBusSession.addAll(listDriverBusSessionLoadMore);
//      listDriverBusSessionLoadMore = List();
//      this.updateState();
//      return;
//    }
//    loadingMore = true;
//    api
//        .getListDriverBusSession(
//            vehicleId: driver.vehicleId,
//            driverId: driver.id,
//            date: dateTimePrevious)
//        .then((value) {
//      if (value != null && value.length > 0)
//        value.forEach((item) {
//          listDriverBusSessionLoadMore.add(item);
//          number--;
//        });
//      else {
//        countDay--;
//      }
//      dateTimeCurrent = dateTimePrevious;
//      dateTimePrevious = datePrevious(dateTimeCurrent);
//      loadingMore = false;
//      if (number > 0)
//        onLoadMore(number, countDay);
//      else {
//        listDriverBusSession.addAll(listDriverBusSessionLoadMore);
//        listDriverBusSessionLoadMore = List();
//      }
//      this.updateState();
//    });
//    this.updateState();
//  }
  String datePrevious(String dateCurrent) {
    DateTime dateTime = DateTime.parse(dateCurrent);
    dateTime = dateTime.add(Duration(days: -1));
    return DateFormat('yyyy-MM-dd').format(dateTime).toString();
  }

  onTapHistory(DriverBusSession driverBusSession) {
    Navigator.pushNamed(context, HistoryTripDetailPage.routeName,
        arguments: driverBusSession);
  }
}
