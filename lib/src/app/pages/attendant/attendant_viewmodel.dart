import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/itemCustomPopupMenu.dart';
import 'package:b2s_driver/src/app/pages/attendantManager/attendant_manager_page.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendantPageViewModel extends ViewModelBase {
  List<DriverBusSession> listDriverBusSession = List();
  bool isShowListButton = false;
  bool isLoadingData = false;
  String busId = "";
  List<CustomPopupMenu> choicesVehicle;
  CustomPopupMenu selectedVehicle;
//  DriverBusSession driverBusSession;
  Driver driver = Driver();
  AttendantPageViewModel() {
    choicesVehicle = driver.listVehicle
        .map((vehicle) =>
            CustomPopupMenu(id: vehicle.id, title: vehicle.licensePlate))
        .toList();
    selectedVehicle = CustomPopupMenu(
        id: driver.listVehicle[0].id,
        title: driver.listVehicle[0].licensePlate,
        subTitle: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    onLoad(selectedVehicle.subTitle);
  }
  onChangeVehicle(String date) {
    driver.vehicleId = selectedVehicle.id;
    driver.vehicleName = selectedVehicle.title;
    onLoad(date);
  }

  onLoad(String date) async {
    print('OnLoad');
    loading = true;
    await api.changeDriverByVehicle(driver.vehicleId);
    api
        .getListDriverBusSession(
            vehicleId: driver.vehicleId, driverId: driver.driverId, date: date)
        .then((value) {
      api.getDriverInfo(driver.id);
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

  onTapItemPickDrop(DriverBusSession driverBusSession) {
    cloudService.busSession
        .createListBusSessionFromDriverBusSession(driverBusSession);
    driverBusSession.saveLocal();
    Navigator.pushNamed(context, AttendantManagerPage.routeName,
        arguments: driverBusSession);
  }

  showNoticeCantStart() {
    LoadingDialog().showMsgDialogWithCloseButton(
        context, 'Không thể bắt đầu chuyến đi của ngày mai.');
  }
}
