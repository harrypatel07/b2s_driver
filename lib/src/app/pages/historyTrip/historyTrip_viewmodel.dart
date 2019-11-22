import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/historyTripDetailPage/historyTrip_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class HistoryTripViewModel extends ViewModelBase {
  List<DriverBusSession> listDriverBusSession = List();
  List<DriverBusSession> listDriverBusSessionLoadMore = List();
  Driver driver = Driver();
  String dateTimeCurrent =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  String dateTimePrevious = '';
  bool loadingMore = false;
  HistoryTripViewModel() {
    loading = true;
    dateTimePrevious = datePrevious(dateTimeCurrent);
//    onLoad(dateTimeCurrent);
      onLoadMore(2, 15);
  }

  ///number : số item cần load
  ///countDate : phạm vi lấy dữ liệu trong vòng n ngày.
  onLoadMore(int number, int countDay) {
    if (countDay <= 0) {
      listDriverBusSession.insertAll(0, listDriverBusSessionLoadMore);
      listDriverBusSessionLoadMore = List();
      loading = false;
      this.updateState();
      return;
    }
    loadingMore = true;
    api
        .getListDriverBusSession(
            vehicleId: driver.vehicleId,
            driverId: driver.id,
            date: dateTimePrevious)
        .then((value) {
      if (value != null && value.length > 0)
        value.forEach((item) {
          listDriverBusSessionLoadMore.insert(0, item);
          number--;
        });
      else {
        countDay--;
      }
      dateTimeCurrent = dateTimePrevious;
      dateTimePrevious = datePrevious(dateTimeCurrent);
      loadingMore = false;
      if (number > 0)
        onLoadMore(number, countDay);
      else {
        listDriverBusSession.insertAll(0, listDriverBusSessionLoadMore);
        listDriverBusSessionLoadMore = List();
        loading = false;
      }
      this.updateState();
    });
    this.updateState();
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
}
