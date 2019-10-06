import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/home/home_page_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/content_row_timeline_widget.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/home_page_timeline_widget.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';
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

  Widget _appBar() {
    return TS24AppBar(
      title: Text(viewModel.listDriverBusSession[0].busID),
      bottom: TabBar(
        controller: viewModel.tabController,
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
            .map((item) => EventTime(
                time: item.time,
                task: item.routeName,
                content: viewModel
                    .getListChildrenForTimeLine(driverBusSession, item.id)
                    .map((children) {
                  var statusID = ChildDrenStatus.getStatusIDByChildrenID(
                      driverBusSession.childDrenStatus, children.id);
                  return ContentRowTimeLine(
                    children: children,
                    isEnablePicked: statusID == 0 ? true : false,
                    status: StatusBus.getStatusByID(StatusBus.list, statusID),
                    onTapPickUp: () {
                      viewModel.onTapPickUp(driverBusSession, children);
                    },
                  );
                }).toList(),
                isFinish: item.status))
            .toList();
    // if(listTimeLine != null)
    // if(listTimeLine[0].content != null)
    // if(listTimeLine[0].content[0].status.statusID == 1)
    // setState(() {
    // listTimeLine[0].task = "123";
    // });

    return Stack(
      children: <Widget>[
        Container(
            color: Colors.grey.shade300,
            child: HomePageTimeLine(
              listTimeLine: listTimeLine,
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TabsPageViewModel tabsPageViewModel = ViewModelProvider.of(context);
    viewModel = tabsPageViewModel.homePageViewModel;
    viewModel.tabController = TabController(length: 2, vsync: this);
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
                    controller: viewModel.tabController,
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
