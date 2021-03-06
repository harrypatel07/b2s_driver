import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/itemCustomPopupMenu.dart';
import 'package:b2s_driver/src/app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleViewModel extends ViewModelBase {
  List<DriverBusSession> listDriverBusSession = List();
  bool isShowListButton = false;
  bool isLoadingData = false;
  String busId = "";
  List<CustomPopupMenu> choicesVehicle;
  CustomPopupMenu selectedVehicle;
//  DriverBusSession driverBusSession;
  Driver driver = Driver();
  ScheduleViewModel() {
    choicesVehicle = driver.listVehicle
        .map((vehicle) => CustomPopupMenu(
            id: vehicle.id,
            title:
                (vehicle.licensePlate is bool || vehicle.licensePlate == null)
                    ? ''
                    : vehicle.licensePlate.toString()))
        .toList();
    selectedVehicle = CustomPopupMenu(
        id: driver.listVehicle[0].id,
        title: (driver.listVehicle[0].licensePlate is bool ||
                driver.listVehicle[0].licensePlate == null)
            ? ''
            : driver.listVehicle[0].licensePlate.toString(),
        subTitle: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    onLoad(selectedVehicle.subTitle);
  }
  onChangeVehicle(String date) {
    driver.vehicleId = selectedVehicle.id;
    driver.vehicleName = selectedVehicle.title;
    onLoad(date);
  }

  onLoad(String date) {
    print('OnLoad');
    loading = true;
    this.updateState();
    api
        .getListDriverBusSession(
            vehicleId: driver.vehicleId, driverId: driver.id, date: date)
        .then((value) {
      api.getDriverInfo(driver.id);
      if (value is List) {
        listDriverBusSession = value;
        if (value.length > 0) busId = value[0].busID;
      }
      loading = false;
      this.updateState();
    });
  }

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

  @override
  void dispose() {
    //streamCloud.cancel();
    super.dispose();
  }

  onTapItemPickDrop(DriverBusSession driverBusSession, bool canStart) {
    cloudService.busSession
        .createListBusSessionFromDriverBusSession(driverBusSession);
    Navigator.pushNamed(context, HomePage.routeName,
            arguments: HomePageArgs(
                driverBusSession: driverBusSession, canStart: canStart))
        .then((result) {
      try {
        if (result) {
          onLoad(selectedVehicle.subTitle);
        }
      } catch (e) {}
    });
  }
}
