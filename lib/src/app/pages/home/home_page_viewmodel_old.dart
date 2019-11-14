import 'dart:async';
import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/menu.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';
import 'package:b2s_driver/src/app/service/index.dart';

class HomePageViewModelOld extends ViewModelBase {
  List<DriverBusSession> listDriverBusSession = [];
  StreamSubscription streamCloud;
  CloudFiresStoreService cloudSerivce = CloudFiresStoreService();
  bool isShowListButton = false;
  TabsPageViewModel tabsPageViewModel;
  HomePageViewModelOld();
  List<Children> listChildrenSS1 = new List();
  List<Children> listChildrenSS2 = new List();

  String busId = "";
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
//
//  onTapPickUp(
//      DriverBusSession driverBusSession, Children children, RouteBus routeBus) {
//    var childrenStatus = driverBusSession.childDrenStatus.singleWhere((item) =>
//        item.childrenID == children.id && item.routeBusID == routeBus.id);
//    switch (childrenStatus.statusID) {
//      case 0:
//        childrenStatus.statusID = 1;
//        break;
//      case 1:
//        childrenStatus.statusID = 0;
//        break;
//      default:
//    }
//    // cloudSerivce.updateDriverBusSession(driverBusSession);
//    // cloudSerivce.updateStatusChildrenBus(children, childrenStatus);
//    this.updateState();
//    //api.getListDriverBusSession();
//  }

  onTapChangeChildrenStatus(DriverBusSession driverBusSession,
      Children children, RouteBus routeBus, int statusID) {
    var childrenStatus = driverBusSession.childDrenStatus.singleWhere((item) =>
        item.childrenID == children.id && item.routeBusID == routeBus.id);
    childrenStatus.statusID = statusID;
    cloudSerivce.busSession.updateDriverBusSession(driverBusSession);
    cloudSerivce.busSession.updateStatusChildrenBus(children, childrenStatus);
    this.updateState();
  }

  listenData() {
    // if (streamCloud != null) streamCloud.cancel();
    // streamCloud = cloudSerivce.listenAllDriverBusSession().listen((onData) {
    //   onData.documentChanges.forEach((item) {
    //     var sessionUpdate = listDriverBusSession.singleWhere((_item) =>
    //         _item.sessionID == item.document.data["sessionID"].toString());
    //     if (sessionUpdate != null) sessionUpdate.fromJson(item.document.data);
    //   });
    //   this.updateState();
    // });
  }

  @override
  void dispose() {
    streamCloud.cancel();
    super.dispose();
  }

  int getCountChildrenByStatus(
      List<ChildDrenStatus> listChildDrenStatus, int statusId, int type) {
    int sum = 0;
    if (type == DriverBusSession.list[0].type) {
      for (int i = 0; i < listChildrenSS1.length; i++)
        for (int j = 0; j < listChildDrenStatus.length; j++)
          if (listChildDrenStatus[j].statusID == statusId &&
              listChildrenSS1[i].id == listChildDrenStatus[j].id) sum++;
    } else {
      for (int i = 0; i < listChildrenSS2.length; i++)
        for (int j = 0; j < listChildDrenStatus.length; j++)
          if (listChildDrenStatus[j].statusID == statusId &&
              listChildrenSS2[i].id == listChildDrenStatus[j].id) sum++;
    }
    return sum;
  }

  void addChildrenByDriverBusSessionType(int type, Children children) {
    if (type == DriverBusSession.list[0].type) {
      if (constraint(listChildrenSS1, children)) listChildrenSS1.add(children);
    } else if (constraint(listChildrenSS2, children))
      listChildrenSS2.add(children);
  }

  bool constraint(List<Children> listChildren, Children children) {
    for (int i = 0; i < listChildren.length; i++)
      if (listChildren[i].id == children.id) return false;
    return true;
  }

  int getLengthListChildrenByBusSessionType(int type) {
    if (type == DriverBusSession.list[0].type)
      return listChildrenSS1.length;
    else
      return listChildrenSS2.length;
  }

  void listContentOnTap(Menu menu) {
    this.updateState();
    tabsPageViewModel = ViewModelProvider.of(context);
    if (tabsPageViewModel != null)
      tabsPageViewModel.onSlideMenuTapped(menu.index);
  }

  loadData() {
    Driver driver = Driver();
    api
        .getListDriverBusSession(
            vehicleId: driver.vehicleId, driverId: driver.id)
        .then((onValue) {
      if (onValue.length > 0) {
        listDriverBusSession = onValue;
        this.updateState();
      }
    });
  }
}
