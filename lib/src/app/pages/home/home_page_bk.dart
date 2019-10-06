import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/home/home_page_viewmodel_bk.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/time_line_bk.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../models/children.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return TS24Scaffold(
              backgroundColor: Colors.white,
//              appBar: _appBar(),
              body: HomeBodyWidget(),
              // drawer: SideMenuPage(),
            );
          }),
    );
  }
}

class HomeBodyWidget extends StatefulWidget {
  @override
  _HomeBodyWidgetState createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget>
    with TickerProviderStateMixin {
  HomePageViewModel viewModel = new HomePageViewModel();
  TabController controller;
  String title = "home";
  @override
  void initState() {
    controller = TabController(vsync: this, length: 2);
    viewModel.initListBusId(viewModel.listDriverBusSession);
    title = viewModel.listBusId[0];
    controller.addListener(handleTabSelected);
    // TODO: implement initState
    super.initState();
  }

  void handleTabSelected() {
    setState(() {
      title = viewModel.listBusId[controller.index];
      print(title);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _appBar() {
    return TS24AppBar(
      title: Text(title),
      bottom: TabBar(
        controller: controller,
        tabs: <Widget>[
          Tab(text: "Depart"),
          Tab(text: "Arrive"),
        ],
      ),
    );
  }

  Widget _body(DriverBusSession driverBusSession) {
    List<ChildDrenRoute> list = driverBusSession.type == 0
        ? viewModel.listChildDrenRouteSession0
        : viewModel
            .listChildDrenRouteSession1; //viewModel.getChildDrenRouteByRouteBusType(driverBusSession.childDrenRoute, driverBusSession.type, RouteBus.list);
    List<Children> listChildren = driverBusSession.type == 0
        ? viewModel.listChildrenSession0
        : viewModel.listChildrenSession1;

    Widget __buildBottomRight() {
      return    Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 5.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                  offset: Offset(
                    -5.0, // horizontal, move right 10
                    -5.0, // vertical, move down 10
                  ),
                )
              ],
              color: Colors.white,
              //border: new Border.all(color: Colors.white, width: 2.0),
              borderRadius: new BorderRadius.circular(0.0),
            ),
            width: MediaQuery.of(context).size.width / 3,
            height: 50,
            //color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          //height:32,
                          margin: EdgeInsets.only(right: 5, left: 5),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: <Widget>[
                              Text("Picked/Sum:",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                              Spacer(),
                              Text(
                                  viewModel
                                          .getCountChildrenByStatus(
                                              listChildren,
                                              driverBusSession.childDrenStatus,
                                              0)
                                          .toString() +
                                      "/" +
                                      listChildren.length.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Container(
                          //height:32,
                          margin: EdgeInsets.only(right: 5, left: 5),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: <Widget>[
                              Text("Vacation:",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                              Spacer(),
                              Text(
                                  viewModel
                                      .getCountChildrenByStatus(listChildren,
                                          driverBusSession.childDrenStatus, 3)
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    }


    return new Stack(
      children: <Widget>[
        Container(
            color: Colors.grey.shade300,
            child: new ListView.builder(
              //list Session Buss
              itemCount: list
                  .length, //ChildDrenRoute.list.length,//viewModel.driverBusSession.childDrenRoute.length, //replace code when have real data
              itemBuilder: (BuildContext context, int index) {
                // if (list.length - 1 == index)
                //   return new Column(
                //     children: <Widget>[
                //       new MyTimeLine(
                //           list[index], driverBusSession.childDrenStatus,viewModel),
                //       new Container(
                //         height: 60,
                //       )
                //     ],
                //   );
                return new MyTimeLine(
                    list[index], driverBusSession.childDrenStatus,viewModel);
              },
            )),
      __buildBottomRight(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    viewModel = ViewModelProvider.of(context);
    viewModel.onInit();
    return MaterialApp(
      home: DefaultTabController(
        length: viewModel.listDriverBusSession.length,
        child: TS24Scaffold(
          appBar: _appBar(),
          body: TabBarView(
            controller: controller,
            children:
            viewModel.listDriverBusSession.map((DriverBusSession driverBusSession) {
              return _body(driverBusSession);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
////////
