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
  List<DriverBusSession> listDriverBusSessionLoadMore = List();
  List<CustomPopupMenu> choicesVehicle;
  CustomPopupMenu selectedVehicle;

  Driver driver = Driver();
  String dateTimeCurrent =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  String dateTimePrevious = '';
  bool loadingMore = false;
  ScrollController controller = ScrollController();
  int _take = 0;
  int _skip = 0;
  HistoryTripViewModel() {
    choicesVehicle = driver.listVehicle
        .map((vehicle) => CustomPopupMenu(id: vehicle.id, title: vehicle.name))
        .toList();
    controller.addListener(() {
      if(controller.offset == controller.position.maxScrollExtent)
        onLoadMore();
    });
    selectedVehicle = CustomPopupMenu(
        id: driver.listVehicle[0].id,
        title: driver.listVehicle[0].name,
        subTitle: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    onLoad();
  }
  void onLoad(){
    loading = true;
    _take = 10;
    _skip = 0;
    api.getHistoryDriver(take: _take,skip: _skip).then((list){
      listHistoryDriverBusSession = list;
      _skip += _take;
      loading = false;
      this.updateState();
    });
    this.updateState();
  }
  void onLoadMore(){
    loadingMore = true;
    api.getHistoryDriver(take: _take,skip: _skip).then((list){
      listHistoryDriverBusSession.addAll(list);
      _skip += _take;
      loadingMore = false;
      this.updateState();
    });
    this.updateState();
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
