import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/menu.dart';
import 'package:b2s_driver/src/app/models/statusBus.dart';
import 'package:b2s_driver/src/app/pages/home/home_page_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/home/profile_children/profile_children.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/timeline_widget.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:b2s_driver/src/app/widgets/ts24_appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  HomePageViewModel viewModel;
  TabController _tabController;
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
                  var tag = children.id.toString() +
                      item.id.toString() +
                      driverBusSession.busID.toString();
                  return HomePageCardTimeLine(
                    children: children,
                    isEnablePicked: statusID == 0 ? true : false,
                    status: statusBus,
                    isEnableTapChildrenContentCard: true,
                    heroTag: tag,
                    onTapPickUp: () {
                      viewModel.onTapPickUp(driverBusSession, children, item);
                    },
                    onTapChangeStatusLeave: () {
                      viewModel.onTapChangeChildrenStatus(
                          driverBusSession, children, item, 3);
                      print("show button call");
                    },
                    onTapShowChildrenProfile: () {
                      Navigator.pushNamed(
                          context, ProfileChildrenPage.routeName,
                          arguments: ProfileChildrenArgs(
                              children: children, heroTag: tag));
                    },
                  );
                }).toList(),
                isFinish: item.status))
            .toList();
    Widget __buildReport() {
      final ___textStyle = TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white);
      final ___numberStyle = TextStyle(
          fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white);
      return Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.only(right: 60),
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
              color: ThemePrimary.primaryColor,
              //border: new Border.all(color: Colors.white, width: 2.0),
              borderRadius:
                  new BorderRadius.only(topLeft: Radius.circular(40))),
          width: MediaQuery.of(context).size.width / 5 * 3,
          height: 65,
          //color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Sỉ số", style: ___textStyle),
                  Text("Tổng", style: ___textStyle),
                  Text("Vắng", style: ___textStyle),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                      viewModel
                          .getCountChildrenByStatus(
                              driverBusSession.childDrenStatus,
                              1,
                              driverBusSession.type)
                          .toString(),
                      style: ___numberStyle),
                  Text(
                      viewModel
                          .getLengthListChildrenByBusSessionType(
                              driverBusSession.type)
                          .toString(),
                      style: ___numberStyle),
                  Text(
                      viewModel
                          .getCountChildrenByStatus(
                              driverBusSession.childDrenStatus,
                              3,
                              driverBusSession.type)
                          .toString(),
                      style: ___numberStyle),
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget __buildButtonStart() {
      return Positioned(
        bottom: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {
            viewModel.listContentOnTap(Menu.tabMenu[1]);
          },
          child: Container(
            padding: EdgeInsets.only(left: 20),
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
                color: Colors.red,
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(200),
                    topRight: Radius.circular(0))),
            width: 70,
            height: 70,
            //color: Colors.white,
            child: Container(
                padding: EdgeInsets.only(left: 12, top: 20),
                child: Text(
                  'BẮT ĐẦU',
                  style: TextStyle(
                      color: Colors.yellow, fontWeight: FontWeight.w900),
                )),
          ),
        ),
      );
    }

    return Stack(
      children: <Widget>[
        Container(
            color: Colors.grey.shade300,
            child: HomePageTimeLineV2(listTimeLine: listTimeLine)),
        __buildReport(),
        __buildButtonStart(),
      ],
    );
  }

  TabsPageViewModel tabsPageViewModel;
  @override
  Widget build(BuildContext context) {
    tabsPageViewModel = ViewModelProvider.of(context);
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
