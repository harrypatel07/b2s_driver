import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page.dart';

import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';

import 'package:flutter/material.dart';

class HomePageViewModel extends ViewModelBase {
  TabsPageViewModel tabsPageViewModel;
  BuildContext context;
  List<DriverBusSession> listDriverBusSession = DriverBusSession.list;
  List<String> listBusId = new List();
  //sessionID type 0
  List<ChildDrenRoute> listChildDrenRouteSession0 = new List();
  List<Children> listChildrenSession0 = new List();
  //sessionID type 1
  List<ChildDrenRoute> listChildDrenRouteSession1 = new List();
  List<Children> listChildrenSession1 = new List();

  void onInit(){
    listChildDrenRouteSession0 = getChildDrenRouteByRouteBusType(listDriverBusSession[0].childDrenRoute, listDriverBusSession[0].type, RouteBus.list);
    listChildDrenRouteSession1 = getChildDrenRouteByRouteBusType(listDriverBusSession[1].childDrenRoute, listDriverBusSession[1].type, RouteBus.list);
    listChildrenSession0 = getListChildrenByChildDrenRoute(this.listChildDrenRouteSession0, Children.list);
    listChildrenSession1 = getListChildrenByChildDrenRoute(this.listChildDrenRouteSession1, Children.list);
    initListBusId(listDriverBusSession);
  }
  void initListBusId(List<DriverBusSession> listDriverBusSession){
    for(int i=0;i<listDriverBusSession.length;i++)
      listBusId.add(listDriverBusSession[i].busID);
  }
  int getCountChildrenByStatus(List<Children> listChildren,List<ChildDrenStatus> listChildDrenStatus,int statusId){
    int sum=0;
    for(int i=0;i<listChildren.length;i++)
      for(int j=0;j<listChildDrenStatus.length;j++)
        if(listChildDrenStatus[j].statusID==statusId&&listChildren[i].id==listChildDrenStatus[j].id )
          sum++;
        return  sum;
  }
  List<Children> getListChildrenByChildDrenRoute(List<ChildDrenRoute> listChildDrenRoute, List<Children> listChildrenFull){
    List<Children> list = new List();
    for(int i=0;i<listChildDrenRoute.length;i++)
      for(int j=0;j<listChildDrenRoute[i].listChildrenID.length;j++)
        for(int k=0;k<listChildrenFull.length;k++)
          if(listChildDrenRoute[i].listChildrenID[j]==listChildrenFull[k].id)
            list.add(listChildrenFull[k]);
          return list;
  }
  List<ChildDrenRoute> getChildDrenRouteByRouteBusType(
      List<ChildDrenRoute> listChildDrenRoute,
      int routeBusType,
      List<RouteBus> listRouteBus) {
    List<ChildDrenRoute> list = new List();
    for (int i = 0; i < listChildDrenRoute.length; i++) {
      for (int j = 0; j < listRouteBus.length; j++)
        if (listChildDrenRoute[i].routeBusID ==
            listRouteBus[j].id) if (listRouteBus[j]
                .type ==
            routeBusType) list.add(listChildDrenRoute[i]);
    }
    return list;
  }

  StatusBus getStatusByChildrenID(int childrenId,List<StatusBus> listStatusBus,List<ChildDrenStatus> listChildDrenStatus){
    for(int i=0;i<listChildDrenStatus.length;i++)
      if(listChildDrenStatus[i].childrenID==childrenId)
        for(int j = 0;j<listStatusBus.length;j++)
          if(listChildDrenStatus[i].statusID==listStatusBus[j].statusID)
            return listStatusBus[j];
          return new StatusBus(-1, "", null);
  }
  void setStatusByChildrenID(int childrenId,int childrenStatus,List<ChildDrenStatus> listChildDrenStatus){
    for(int i=0;i<listChildDrenStatus.length;i++)
      if(listChildDrenStatus[i].childrenID==childrenId)
        listChildDrenStatus[i].statusID = childrenStatus;
  }
}
