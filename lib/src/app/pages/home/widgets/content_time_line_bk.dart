import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/home/home_page_viewmodel_bk.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/children_row_bk.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';
import 'package:flutter/material.dart';

class ContentTimeLineWidget extends StatefulWidget {
  final HomePageViewModel viewModel;
  final List<ChildDrenStatus> listChildDrenStatus;
  final ChildDrenRoute childDrenRoute;
  ContentTimeLineWidget(
      {Key key, this.childDrenRoute, this.listChildDrenStatus, this.viewModel})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => new ContentWidgetState(
      this.childDrenRoute, this.listChildDrenStatus, this.viewModel);
}

class ContentWidgetState extends State<ContentTimeLineWidget> {
  HomePageViewModel viewModel;
  ChildDrenRoute childDrenRoute;
  List<ChildDrenStatus> listChilDrenStatus;
  var listChildren = List<Widget>();
  ContentWidgetState(
      this.childDrenRoute, this.listChilDrenStatus, this.viewModel);

  @override
  void initState() {
    // TODO: implement initState
    for (var children in Children.list) {
      for (var i in childDrenRoute.listChildrenID)
        if (children.id == i) {
          for (var s in listChilDrenStatus)
            if (s.childrenID == children.id)
              listChildren.add(new Padding(
                  padding: new EdgeInsets.only(top: 5.0),
                  child: new ChildrenRow(children, s.statusID, viewModel)));
        }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(left: 20.0, top: 10.0),
            child: new Container(
              margin: EdgeInsets.only(right: 10),
              //color: Colors.green,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Text(
                    RouteBus.list[childDrenRoute.routeBusID - 1].routeName
                        .toUpperCase(),
                    style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      color: (RouteBus
                                  .list[childDrenRoute.routeBusID - 1].status ==
                              true)
                          ? Colors.green
                          : Colors.black,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.access_time,
                      color: Colors.grey,
                    ),
                  ),
                  Text(RouteBus.list[childDrenRoute.routeBusID - 1].time),
                ],
              ),
            ),
          ),
          new Column(children: listChildren),
        ],
      ),
    );
  }
}
