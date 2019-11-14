import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/timeline_widget.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page_viewmodel.dart';


class BottomSheetCustomViewModel extends ViewModelBase {
  List<TimeLineEvent> listTimeLine;
  LocateBusPageViewModel localBusViewModel;
  BottomSheetCustomViewModel();

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

  onTapPickUpLocateBus(
      DriverBusSession driverBusSession, Children children, RouteBus routeBus) {
    var childrenStatus = driverBusSession.childDrenStatus.singleWhere((item) =>
        item.childrenID == children.id && item.routeBusID == routeBus.id);
    if(childrenStatus.typePickDrop==0) {
//      var childrenStatusDrop = driverBusSession.childDrenStatus.singleWhere((item)=>item.childrenID==children.id&&item.id!=childrenStatus.id);
      switch (childrenStatus.statusID) {
        case 0:
          childrenStatus.statusID = 1;
//          childrenStatusDrop.statusID = 1;
          updateStatusPickChildren(childrenStatus.id);
          break;
        default:
      }
    }
    else
      switch (childrenStatus.statusID){
        case 1:
          childrenStatus.statusID = 2;
          updateStatusDropChildren(childrenStatus.id);
          break;
        default:
      }
    this.updateState();
    if (localBusViewModel != null) {
//      localBusViewModel.driverBusSession.totalChildrenInBus += 1;
      localBusViewModel.updateState();
    }
  }
  updateStatusPickChildren(int childrenStatusId){
    List<int> listIdPicking = List();
    listIdPicking.add(childrenStatusId);
    api.updateStatusPickByIdPicking(listIdPicking).then((r){
      if(r)
        print('Success');
      else
        print('fails');
    });
  }
  updateStatusDropChildren(int childrenStatusId){
    List<int> listIdDroping = List();
    listIdDroping.add(childrenStatusId);
    api.updateStatusDropByIdChildren(listIdDroping).then((r){
      if(r)
        print('Success');
      else
        print('fails');
    });
  }
//  onTapChangeChildrenStatus(DriverBusSession driverBusSession,
//      Children children, RouteBus routeBus, int statusID) {
//    var childrenStatus = driverBusSession.childDrenStatus.singleWhere((item) =>
//    item.childrenID == children.id && item.routeBusID == routeBus.id);
//    childrenStatus.statusID = statusID;
//    cloudSerivce.busSession.updateDriverBusSession(driverBusSession);
//    cloudSerivce.busSession.updateStatusChildrenBus(children, childrenStatus);
//    this.updateState();
//  }
}
