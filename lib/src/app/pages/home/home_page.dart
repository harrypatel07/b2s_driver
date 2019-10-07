import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/home/home_page_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/home_page_timeline_widget.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/home_page_timeline_widget2.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';
import 'package:b2s_driver/src/app/widgets/home_page_cart_timeline.dart';
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
            .map((item) => TimeLineEventTime(
                time: item.time,
                task: item.routeName,
                content: viewModel
                    .getListChildrenForTimeLine(driverBusSession, item.id)
                    .map((children) {
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

    return Stack(
      children: <Widget>[
        Container(
            color: Colors.grey.shade300,
            child: HomePageTimeLineV2(listTimeLine: listTimeLine)
            // child: ContainerHomeTimeLine(evenTime: listTimeLine[0]),
            )
      ],
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging)
        // Tab Changed tapping on new tab
        viewModel.heightTimeline = [];
      else if (_tabController.index != _tabController.previousIndex)
        // Tab Changed swiping to a new tab
        viewModel.heightTimeline = [];
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
