import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/home/home_page_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/timeline_widget.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:b2s_driver/src/app/widgets/ts24_appbar_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  HomePageViewModel viewModel;
  TabController _tabController;
  Widget _appBar() {
    return TS24AppBar(
      title: Text(viewModel.listDriverBusSession[0].busID),
      bottom: TabBar(
        controller: _tabController,
        tabs: <Widget>[
          Tab(text: "Chuyến đi"),
          Tab(text: "Chuyến về"),
        ],
      ),
    );
  }

  Widget _buildBody(DriverBusSession driverBusSession) {
    var listTimeLine =
        RouteBus.getListRouteBusByType(RouteBus.list, driverBusSession.type)
            .map((item) => TimeLineEvent(
                time: item.time,
                task: item.routeName,
                content: viewModel
                    .getListChildrenForTimeLine(driverBusSession, item.id)
                    .map((children) {
                  viewModel.addChildrenByDriverBusSessionType(
                      driverBusSession.type, children);
                  final statusID = ChildDrenStatus.getStatusIDByChildrenID(
                      driverBusSession.childDrenStatus, children.id, item.id);
                  final statusBus =
                      StatusBus.getStatusByID(StatusBus.list, statusID);
                  return HomePageCardTimeLine(
                    children: children,
                    isEnablePicked: statusID == 0 ? true : false,
                    status: statusBus,
                    onTapPickUp: () {
                      viewModel.onTapPickUp(driverBusSession, children, item);
                    },
                  );
                }).toList(),
                isFinish: item.status))
            .toList();
    Widget __buildBottomRight() {
      return Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.only(left: 10),
          decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 1.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                  offset: Offset(
                    -1.0, // horizontal, move right 10
                    -1.0, // vertical, move down 10
                  ),
                )
              ],
              color: Colors.green,
              //border: new Border.all(color: Colors.white, width: 2.0),
              borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
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
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                            Spacer(),
                            Text(
                                viewModel
                                        .getCountChildrenByStatus(
                                            driverBusSession.childDrenStatus,
                                            1,
                                            driverBusSession.type)
                                        .toString() +
                                    "/" +
                                    viewModel
                                        .getLengthListChildrenByBusSessionType(
                                            driverBusSession.type)
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
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
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                            Spacer(),
                            Text(
                                viewModel
                                    .getCountChildrenByStatus(
                                        driverBusSession.childDrenStatus,
                                        3,
                                        driverBusSession.type)
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
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

    return Stack(
      children: <Widget>[
        Container(
            color: Colors.grey.shade300,
            child: HomePageTimeLineV2(listTimeLine: listTimeLine)
            // child: ContainerHomeTimeLine(evenTime: listTimeLine[0]),
            ),
        __buildBottomRight(),
      ],
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.addListener(() {
    //   if (_tabController.indexIsChanging)
    //     // Tab Changed tapping on new tab
    //     viewModel.heightTimeline = [];
    //   else if (_tabController.index != _tabController.previousIndex)
    //     // Tab Changed swiping to a new tab
    //     viewModel.heightTimeline = [];
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.listenData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabsPageViewModel tabsPageViewModel = ViewModelProvider.of(context);
    viewModel = tabsPageViewModel.homePageViewModel;
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return MaterialApp(
              home: DefaultTabController(
                length: 2,
                child: TS24Scaffold(
                  appBar: _appBar(),
                  body: TabBarView(
                    controller: _tabController,
                    children:
                        viewModel.listDriverBusSession.map((driverBusSession) {
                      return _buildBody(driverBusSession);
                    }).toList(),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
