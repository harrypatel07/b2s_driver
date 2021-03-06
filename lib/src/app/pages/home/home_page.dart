import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/statusBus.dart';
import 'package:b2s_driver/src/app/pages/home/home_page_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/timeline_widget.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:b2s_driver/src/app/widgets/ts24_appbar_widget.dart';
import 'package:b2s_driver/src/app/widgets/ts24_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  final HomePageArgs args;
  const HomePage({Key key, this.args}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class HomePageArgs {
  final DriverBusSession driverBusSession;
  final bool canStart;
  HomePageArgs({this.driverBusSession, this.canStart});
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  HomePageViewModel viewModel = HomePageViewModel();
  @override
  void initState() {
    viewModel.driverBusSession = widget.args.driverBusSession;
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
        onPressed: () => Navigator.pop(context,viewModel.isChangRouteBus),
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

    Widget __arrangeListRouteButton() {
      return Positioned(
        bottom: 0,
        left: 0,
        width: 90,
        height: 65,
        child: TS24Button(
          onTap: (){
            viewModel.onTapArrangeListRoute(driverBusSession);
          },
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                  offset: Offset(
                    -1.0, // horizontal, move right 10
                    -1.0, // vertical, move down 10
                  ),
                ),
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                  offset: Offset(
                    1.0, // horizontal, move right 10
                    1.0, // vertical, move down 10
                  ),
                )
              ],
              color: ThemePrimary.primaryColor),
          child: Container(
            padding: EdgeInsets.only(left: 10,right: 10),
            alignment: Alignment.center,
            child: Text(
              "Sắp xếp lịch trình",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
        ),
      );
    }

    Widget __buildButtonStart() {
      return Positioned(
        bottom: 0,
        right: 0,
        child: TS24Button(
          onTap: () {
            if (widget.args.canStart)
              viewModel.onStart();
            else
              viewModel.showNoticeCantStart();
          },
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
                  topLeft: Radius.circular(200), topRight: Radius.circular(0))),
          width: 70,
          height: 70,
          //color: Colors.white,
          child: Container(
//              padding: EdgeInsets.only(left: 20)
              padding: EdgeInsets.only(left: 32, top: 20),
              child: Text(
                'BẮT ĐẦU',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
              )),
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
        __arrangeListRouteButton(),
      ],
    );
  }

//  TabsPageViewModel tabsPageViewModel;
  @override
  Widget build(BuildContext context) {
    //tabsPageViewModel = ViewModelProvider.of(context);
    //viewModel = tabsPageViewModel.homePageViewModel;
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return WillPopScope(
              child: TS24Scaffold(
                appBar: _appBar(),
                body: _buildBody(widget.args.driverBusSession),
              ),
              onWillPop: ()async{
                Navigator.pop(context,viewModel.isChangRouteBus);
                return false;
              },
            );
          }),
    );
  }
}
