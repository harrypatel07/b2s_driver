import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/statusBus.dart';
import 'package:b2s_driver/src/app/pages/home/home_page_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/timeline_widget.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:b2s_driver/src/app/widgets/ts24_appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  final DriverBusSession driverBusSession;
  const HomePage({Key key, this.driverBusSession}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  HomePageViewModel viewModel = HomePageViewModel();
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   viewModel.loadData();
    // });
    viewModel.loadData();
    super.initState();
  }

  Widget _appBar() {
    return TS24AppBar(
      title: Text('LỊCH TRÌNH'),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildBody(DriverBusSession driverBusSession) {
    var __index = 0;
    var listTimeLine = driverBusSession.listRouteBus
        .map((item) => TimeLineEvent(
            id: item.id,
            time: item.time,
            task: item.routeName,
            content: viewModel
                .getListChildrenForTimeLine(driverBusSession, item.id)
                .map((children) {
              __index++;
              viewModel.addChildrenByDriverBusSessionType(
                  driverBusSession.type, children);
              final status = ChildDrenStatus.getStatusByChildrenID(
                  driverBusSession.childDrenStatus, children.id, item.id);
              final statusBus =
                  StatusBus.getStatusByID(StatusBus.list, status.statusID);
              var tag = children.id.toString() +
                  item.id.toString() +
                  status.id.toString() +
                  __index.toString();
              return HomePageCardTimeLine(
                children: children,
                isEnablePicked: status.statusID == 0 ? true : false,
                status: statusBus,
                heroTag: tag,
                typePickDrop: status.typePickDrop,
                onTapPickUp: () {
//                  viewModel.onTapPickUp(driverBusSession, children, item);
                },
                onTapChangeStatusLeave: () {
//                  viewModel.onTapChangeChildrenStatus(
//                      driverBusSession, children, item, 3);
//                  print("show button call");
                },
                onTapShowChildrenProfile: () {
                  viewModel.onTapShowChildrenProfile(children, tag);
                },
              );
            }).toList(),
            isFinish: item.status))
        .toList();
    Widget __buildReport() {
      final ___textStyle = TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700]);
      final ___numberStyle = TextStyle(
          fontSize: 16, fontWeight: FontWeight.w900, color: Colors.grey[700]);
      return Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.only(right: 60),
          decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 0.5, // has the effect of softening the shadow
                  spreadRadius: 0.5, // has the effect of extending the shadow
                  offset: Offset(
                    -0.5, // horizontal, move right 10
                    -0.5, // vertical, move down 10
                  ),
                )
              ],
              color: Colors.grey[200],
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
                  Text("Tổng học sinh", style: ___textStyle),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                      viewModel
                          .getLengthListChildrenByBusSessionType(
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
            viewModel.onStart();
          },
          child: Container(
            padding: EdgeInsets.only(left: 20),
            decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1.0, // has the effect of softening the shadow
                    spreadRadius: 1.0, // has the effect of extending the shadow
                    offset: Offset(
                      -1.0, // horizontal, move right 10
                      -1.0, // vertical, move down 10
                    ),
                  )
                ],
                color: ThemePrimary.primaryColor,
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
                      color: Colors.white, fontWeight: FontWeight.w900),
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

//  TabsPageViewModel tabsPageViewModel;
  @override
  Widget build(BuildContext context) {
    //tabsPageViewModel = ViewModelProvider.of(context);
    //viewModel = tabsPageViewModel.homePageViewModel;
    viewModel.context = context;
    viewModel.driverBusSession = widget.driverBusSession;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return MaterialApp(
              home: TS24Scaffold(
                appBar: _appBar(),
                body: _buildBody(widget.driverBusSession),
              ),
            );
          }),
    );
  }
}
