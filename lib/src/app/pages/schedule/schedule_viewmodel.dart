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
        .map((vehicle) => CustomPopupMenu(id: vehicle.id, title: vehicle.name))
        .toList();
    selectedVehicle = CustomPopupMenu(
        id: driver.listVehicle[0].id,
        title: driver.listVehicle[0].name,
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
    api
        .getListDriverBusSession(
            vehicleId: driver.vehicleId, driverId: driver.id, date: date)
        .then((value) {
      if (value is List) {
        listDriverBusSession = value;
        if (value.length > 0) busId = value[0].busID;
      }
      loading = false;
      this.updateState();
    });
    this.updateState();
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

  onTapItemPick() {
    cloudService.busSession
        .createListBusSessionFromDriverBusSession(listDriverBusSession[0]);
    Navigator.pushNamed(context, HomePage.routeName,
        arguments: listDriverBusSession[0]);
  }

  onTapItemDrop() {
    cloudService.busSession
        .createListBusSessionFromDriverBusSession(listDriverBusSession[1]);
    Navigator.pushNamed(context, HomePage.routeName,
        arguments: listDriverBusSession[1]);
  }
}
