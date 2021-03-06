import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/helper/utils.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/pages/attendantManager/attendant_manager_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/timeline_widget.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/ts24_appbar_widget.dart';
import 'package:b2s_driver/src/app/widgets/ts24_button_widget.dart';
import 'package:b2s_driver/src/app/widgets/ts24_scaffold_widget.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:intl/intl.dart';

class AttendantManagerPage extends StatefulWidget {
  static const String routeName = "/attendantManager";
  final DriverBusSession driverBusSession;

  const AttendantManagerPage({Key key, this.driverBusSession})
      : super(key: key);
  @override
  _AttendantManagerPageState createState() => _AttendantManagerPageState();
}

class _AttendantManagerPageState extends State<AttendantManagerPage> {
  AttendantManagerViewModel viewModel = AttendantManagerViewModel();
  @override
  void initState() {
    viewModel.driverBusSession = widget.driverBusSession;
    viewModel.onCreateDriverBusSessionReport();
    viewModel.listenData();
    super.initState();
  }

  Widget _appBar() {
    return TS24AppBar(
      title: Text('Lịch trình'),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => viewModel.onTapBackButton(),
      ),
      actions: <Widget>[
        (viewModel.bluetoothDeviceConnected != null)
            ? StreamBuilder<BluetoothDeviceState>(
                stream: viewModel.bluetoothDeviceConnected.state,
                initialData: BluetoothDeviceState.disconnected,
                builder: (c, snapshot) {
                  return InkWell(
                    onTap: () {
                      viewModel.onTapSettingBluetoothDevice();
                    },
                    child: Center(
                        child: viewModel.isBluetoothOn
                            ? (snapshot.data == BluetoothDeviceState.connected)
                                ? Icon(
                                    Icons.settings_remote,
                                    color: Colors.white,
                                    size: 25,
                                  )
                                : CircleAvatar(
                                    radius: 13.0,
                                    backgroundImage: AssetImage(
                                        "assets/images/scan-device-signal.gif"),
                                    backgroundColor: Colors.transparent,
                                  )
                            : Icon(
                                Icons.bluetooth_disabled,
                                color: Colors.grey,
                                size: 25,
                              )),
                  );
                },
              )
            : InkWell(
                onTap: () {
                  viewModel.onTapSettingBluetoothDevice();
                },
                child: Center(
                    child: viewModel.isBluetoothOn
                        ? CircleAvatar(
                            radius: 13.0,
                            backgroundImage: AssetImage(
                                "assets/images/scan-device-signal.gif"),
                            backgroundColor: Colors.transparent,
                          )
                        : Icon(
                            Icons.bluetooth_disabled,
                            color: Colors.white,
                            size: 25,
                          )),
              )
      ],
    );
  }

  Widget _buildBody(DriverBusSession driverBusSession) {
    Widget __content(int index, RouteBus routeBus) {
      List<Children> listChildren =
          viewModel.getListChildrenForTimeLine(driverBusSession, routeBus.id);
      int totalChild = viewModel.countChildrenPickDrop(routeBus.id, 0);
      int totalLeave = viewModel.countChildrenPickDrop(routeBus.id, 1);
//      listChildren.asMap()
      listChildren.forEach((child) {
        var _status = driverBusSession.childDrenStatus.where((status) =>
            (status.childrenID == child.id &&
                status.routeBusID == routeBus.id &&
                status.statusID == 3));
        if (_status.length > 0) totalLeave++;
      });
      bool checkTomorrow = dateDifferent(
          DateFormat('yyyy-MM-dd').parse(routeBus.date), DateTime.now());
      return InkWell(
        onTap: () {
          if (!checkTomorrow) viewModel.onTap(routeBus, index + 1);
        },
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: new BoxDecoration(
            color: Colors.white, //new Color(0xFF333366),
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: new Offset(0.0, 10.0),
              ),
            ],
          ),
//        color: Colors.green,
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 4,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
//                width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Học sinh đón:'),
                            Text(totalChild.toString())
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
//                width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Học sinh trả:'),
                            Text(totalLeave.toString())
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Flexible(
                flex: 1,
                child: Container(
//                color: ThemePrimary.primaryColor,
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                    color: checkTomorrow
                        ? Colors.grey
                        : ThemePrimary.primaryColor, //new Color(0xFF333366),
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.circular(8.0),
//                  boxShadow: <BoxShadow>[
//                    new BoxShadow(
//                      color: Colors.black12,
//                      blurRadius: 10.0,
//                      offset: new Offset(0.0, 10.0),
//                    ),
//                  ],
                  ),
                  child: Text(
                    'Chọn',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    var listTimeLine = driverBusSession.listRouteBus
        .asMap()
        .map((index, item) => MapEntry(
            index,
            TimeLineEvent(
                id: item.id,
                time: item.time,
                task: item.routeName,
                content: [__content(index, item)],
                isFinish: item.status)))
        .values
        .toList();
    Widget __buildReport() {
      final ___textStyle = TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: ThemePrimary.primaryColor);
      final ___numberStyle = TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: ThemePrimary.primaryColor);
      return Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.only(right: 60, top: 5),
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
          width: MediaQuery.of(context).size.width,
          height: 65,
          //color: Colors.white,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "Học sinh đăng ký",
                        textAlign: TextAlign.center,
                        style: ___textStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "Học sinh trên xe",
                        textAlign: TextAlign.center,
                        style: ___textStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "Học sinh báo nghỉ",
                        textAlign: TextAlign.center,
                        style: ___textStyle,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Text(
                        viewModel.driverBusSession.totalChildrenRegistered
                            .toString(),
                        textAlign: TextAlign.center,
                        style: ___numberStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Text(
                        viewModel.driverBusSession.totalChildrenInBus
                            .toString(),
                        textAlign: TextAlign.center,
                        style: ___numberStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Text(
                        viewModel.driverBusSession.totalChildrenLeave
                            .toString(),
                        textAlign: TextAlign.center,
                        style: ___numberStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget __buildButtonFinish() {
      return Positioned(
        bottom: 0,
        right: 0,
        child: TS24Button(
          onTap: () {
            viewModel.onTapFinish();
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
          width: 80,
          height: 70,
          child: Container(
              padding: EdgeInsets.only(right: 10, top: 25),
              child: Text(
                'Hoàn Thành',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 13),
                textAlign: TextAlign.right,
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
        __buildButtonFinish(),
        if (viewModel.loading)
          Container(
            color: Colors.black38,
            alignment: Alignment.center,
            child: LoadingIndicator.spinner(
                context: context, loading: viewModel.loading),
          )
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
                body: _buildBody(widget.driverBusSession),
              ),
              onWillPop: () async {
                viewModel.onTapBackButton();
                return false;
              },
            );
          }),
    );
  }
}
