import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/pages/bottomSheet/bottom_sheet_custom.dart';
import 'package:b2s_driver/src/app/service/cloudFirestore-service.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:flutter/material.dart';

class BottomSheetViewModelBase extends ViewModelBase{
  DriverBusSession driverBusSession;
  CloudFiresStoreService cloudSerivce = CloudFiresStoreService();
  BottomSheetViewModelBase();
  int position;
  RouteBus routeBus;
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
  onCreateDriverBusSessionReport() {
    //listChildrenPaidTicket = Children.getListChildrenPaidTicket(driverBusSession.listChildren);
    driverBusSession.totalChildrenLeave = getCountChildrenByStatusBusId(3);
    driverBusSession.totalChildrenInBus = getCountChildrenByStatusBusId(1);
    driverBusSession.totalChildrenPick = getCountChildrenByStatusBusId(1) +
        getCountChildrenByStatusBusId(2) +
        getCountChildrenByStatusBusId(4);
    driverBusSession.totalChildrenDrop =
        getCountChildrenByStatusBusId(2) + getCountChildrenByStatusBusId(4);
  }
  int getCountChildrenByStatusBusId(statusBusId) {
    int sum = 0;
    driverBusSession.listChildren.forEach((child) {
      List<ChildDrenStatus> checkConstraint = driverBusSession.childDrenStatus
          .where((status) =>
      status.childrenID == child.id && status.statusID == statusBusId)
          .toList();
      if (checkConstraint.length > 0) sum++;
    });
    return sum;
  }
  onTap(RouteBus _route, int _pos) {
    this.position = _pos;
    this.routeBus = _route;
    if (_pos >= 2) {
      if (countRouteBusNotFinishPrev(_pos) == 0)
        showBottomSheet(_pos);
      else {
        LoadingDialog()
            .showMsgDialogWithButton(context, getTextPopupConfirm(_pos))
            .then((result) {
              try {
                if (result) showBottomSheet(_pos);
              }catch(e){}
        });
      }
    } else
      showBottomSheet(_pos);
  }
  String getTextPopupConfirm(int pos) {
    String listPoint = '';
    for (int i = 0; i < pos - 1; i++)
      if (!driverBusSession.listRouteBus[i].status) {
        (i > 0 && i < pos - 1)
            ? listPoint == ''
            ? listPoint += '${i + 1}'
            : listPoint += ' - ${i + 1}'
            : listPoint += '${i + 1}';
      }
    var many = '';
    if (countRouteBusNotFinishPrev(pos) > 1) {
      many = 'các ';
      return """Bạn chưa hoàn thành $manyđiểm trước đó:
  $listPoint
Bạn có muốn tiếp tục?
""";
    }else return """Bạn chưa hoàn thành $manyđiểm trước đó: $listPoint
Bạn có muốn tiếp tục?
""";
  }

  int countRouteBusNotFinishPrev(int pos) {
    int count = 0;
    for (int i = 0; i < pos - 1; i++)
      if (!driverBusSession.listRouteBus[i].status) count++;
    return count;
  }

  void showBottomSheet(int pos) {
    try {
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext bc) {
            return BottomSheetCustom(
                arguments: BottomSheetCustomArgs(viewModel: this));
          }).then((_){
              this.updateState();
      });
    }catch(e){
      print(e);
    }
  }
}