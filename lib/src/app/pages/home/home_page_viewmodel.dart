import 'dart:async';

import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/childrenBusSession.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/service/index.dart';

class HomePageViewModel extends ViewModelBase {
  List<DriverBusSession> listDriverBusSession = DriverBusSession.list;
  StreamSubscription streamCloud;
  CloudFiresStoreService cloudSerivce = CloudFiresStoreService();
  HomePageViewModel();

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

  onTapPickUp(
      DriverBusSession driverBusSession, Children children, RouteBus routeBus) {
    var childrenStatus = driverBusSession.childDrenStatus.singleWhere((item) =>
        item.childrenID == children.id && item.routeBusID == routeBus.id);
    switch (childrenStatus.statusID) {
      case 0:
        childrenStatus.statusID = 1;
        break;
      case 1:
        childrenStatus.statusID = 0;
        break;
      default:
    }
    cloudSerivce.updateDriverBusSession(driverBusSession);
    cloudSerivce.updateStatusChildrenBus(children, childrenStatus);
    this.updateState();
  }

  listenData() {
    if (streamCloud != null) streamCloud.cancel();
    streamCloud = cloudSerivce.listenAllDriverBusSession().listen((onData) {
      onData.documentChanges.forEach((item) {
        var sessionUpdate = listDriverBusSession.singleWhere((_item) =>
            _item.sessionID == item.document.data["sessionID"].toString());
        if (sessionUpdate != null) sessionUpdate.fromJson(item.document.data);
      });
      this.updateState();
    });
  }

  @override
  void dispose() {
    streamCloud.cancel();
    super.dispose();
  }
}
