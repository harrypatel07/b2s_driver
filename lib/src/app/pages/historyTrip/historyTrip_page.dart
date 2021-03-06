import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/itemCustomPopupMenu.dart';
import 'package:b2s_driver/src/app/pages/historyTrip/historyTrip_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/dash.dart';
import 'package:b2s_driver/src/app/widgets/empty_widget.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:b2s_driver/src/app/widgets/ts24_scaffold_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class HistoryTripPage extends StatefulWidget {
  static const String routeName = "/historyTrip";
  @override
  _HistoryTripPageState createState() => _HistoryTripPageState();
}

class _HistoryTripPageState extends State<HistoryTripPage> {
  HistoryTripViewModel viewModel = HistoryTripViewModel();
  @override
  Widget build(BuildContext context) {
    Widget _item(
        {DriverBusSession driverBusSession,
        String url,
        String title,
        Function onTap}) {
      Widget __image() {
        // String url = GoogleMapService.getUrlImageFromMultiMarker(
        //   width: (MediaQuery.of(context).size.width.toInt() - 40) * 2,
        //   height: 170 * 2,
        //   listLatLng: driverBusSession.listRouteBus
        //       .map((route) => LatLng(route.lat, route.lng))
        //       .toList(),
        //   listPosition: driverBusSession.listRouteBus
        //       .map((route) => LatLng(route.lat, route.lng))
        //       .toList(),
        // );
//       http.Response response
        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
//        color: Colors.orange,
            height: 170,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18)),
                child: CachedNetworkImage(
                    imageUrl: url,
                    imageBuilder: (context, imageProvider) => Image(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ))),
          ),
        );
      }

      Widget __right() {
        return Flexible(
          flex: 8,
          child: Container(
            height: driverBusSession.childDrenRoute.length < 3
                ? driverBusSession.childDrenRoute.length * 44.0
                : 3 * 44.0,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: driverBusSession.childDrenRoute.length,
              itemBuilder: (context, index) {
                return new LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  int routeBusID =
                      driverBusSession.childDrenRoute[index].routeBusID;
                  var routeBus = driverBusSession.listRouteBus
                      .firstWhere((route) => route.id == routeBusID);
                  if (index == 0 ||
                      index == driverBusSession.childDrenRoute.length - 1)
                    return Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 0.0, top: 0.0),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 43.5,
                                      child: Text(
                                        routeBus.routeName,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    (index <
                                            driverBusSession
                                                    .childDrenRoute.length -
                                                1)
                                        ? Container(
                                            height: 1,
                                            color: Colors.grey[500],
                                          )
                                        : Container(
                                            height: 1,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  else if (driverBusSession.childDrenRoute.length > 3) {
                    if (index == driverBusSession.childDrenRoute.length - 2) {
                      return Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 0.0, top: 0.0),
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: 43.5,
                                        child: Text(
                                          '... $index trạm ...',
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      (index <
                                              driverBusSession
                                                      .childDrenRoute.length -
                                                  1)
                                          ? Container(
                                              height: 1,
                                              color: Colors.grey[500],
                                            )
                                          : Container(
                                              height: 1,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else
                      return SizedBox();
                  } else
                    return Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 0.0, top: 0.0),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 43.5,
                                      child: Text(
                                        routeBus.routeName,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    (index <
                                            driverBusSession
                                                    .childDrenRoute.length -
                                                1)
                                        ? Container(
                                            height: 1,
                                            color: Colors.grey[500],
                                          )
                                        : Container(
                                            height: 1,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                });
              },
            ),
          ),
        );
      }

      Widget __left() {
        return Flexible(
          flex: 1,
          child: Container(
            height: driverBusSession.childDrenRoute.length <= 3
                ? driverBusSession.childDrenRoute.length * 44.0
                : 3 * 44.0,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: driverBusSession.childDrenRoute.length,
              itemBuilder: (context, index) {
                return new LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 0.0, top: 0.0),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  (index == 0)
                                      ? Container(
                                          width: 10,
                                        )
                                      : Container(),
                                  (index == 0)
                                      ? SizedBox(
                                          height: 10,
                                        )
                                      : (index <= 2)
                                          ? Dash(
                                              length: 25.0 + index * 1.0,
                                              dashLength: 2,
                                              direction: Axis.vertical,
                                              dashColor:
                                                  ThemePrimary.primaryColor,
                                              dashThickness: 1,
                                            )
                                          : SizedBox(),
                                  (index == 0)
                                      ? Transform.rotate(
                                          angle: 3.14,
                                          child: Icon(
                                            Icons.navigation,
                                            color: ThemePrimary.primaryColor,
                                          ),
                                        )
                                      : (index == 1 ||
                                              index ==
                                                  driverBusSession
                                                          .childDrenRoute
                                                          .length -
                                                      1)
                                          ? Icon(
                                              Icons.radio_button_unchecked,
                                              color: Colors.orange,
                                              size: 15,
                                            )
                                          : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
              },
            ),
          ),
        );
      }

      Widget __content() {
        return Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(title + ", "),
                        Text(
                          driverBusSession.listRouteBus[0].time.substring(0,
                              driverBusSession.listRouteBus[0].time.length - 3),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.group,
                          color: ThemePrimary.primaryColor,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          driverBusSession.listChildren.length.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 3,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 3,
                        color: ThemePrimary.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  __left(),
                  __right(),
                ],
              )
            ],
          ),
        );
      }

//      Widget __buttonSupport() {
//        return InkWell(
//          onTap: onTap,
//          child: ClipRRect(
//            borderRadius: new BorderRadius.only(
//                bottomRight: Radius.circular(18),
//                bottomLeft: Radius.circular(18)),
//            child: Container(
////          padding: EdgeInsets.only(right: 10,left: 10),
//              child: Container(
//                alignment: Alignment.center,
//                width: MediaQuery.of(context).size.width - 25,
//                height: 50,
//                color: driverBusSession.status
//                    ? Colors.green[300]
//                    : Colors.black87,
//                child: driverBusSession.status
//                    ? Text(
//                        'ĐÃ HOÀN THÀNH',
//                        textAlign: TextAlign.center,
//                        style: TextStyle(color: Colors.white),
//                      )
//                    : Text(
//                        'CHỌN',
//                        textAlign: TextAlign.center,
//                        style: TextStyle(color: Colors.white),
//                      ),
//              ),
//            ),
//          ),
//        );
//      }

      return Container(
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.black26,
                blurRadius: 20.0,
              ),
            ]),
            child: Card(
//            decoration: new BoxDecoration(
//                boxShadow: [
//                  BoxShadow(
//                    color: Colors.grey[300],
//                    blurRadius: 3.0, // has the effect of softening the shadow
//                    spreadRadius:
//                        3.0, // has the effect of extending the shadow
//                    offset: Offset(
//                      3.0, // horizontal, move right 10
//                      3.0, // vertical, move down 10
//                    ),
//                  ),
//                  BoxShadow(
//                    color: Colors.grey[300],
//                    blurRadius: 3.0, // has the effect of softening the shadow
//                    spreadRadius:
//                        3.0, // has the effect of extending the shadow
//                    offset: Offset(
//                      -3.0, // horizontal, move right 10
//                      0.0, // vertical, move down 10
//                    ),
//                  )
//                ],
//                color: Colors.grey[200],

//                shape: new BorderRadius.circular(25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Stack(
                  children: <Widget>[
                    __image(),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 170,
                        ),
                        __content(),
//                        __buttonSupport(),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      );
    }

    void _selectVehicle(CustomPopupMenu choice) {
      viewModel.selectedVehicle = choice;
      viewModel.onChangeVehicle();
    }

    Widget _appBar() {
      return TS24AppBar(
        backgroundColorStart: ThemePrimary.primaryColor,
        backgroundColorEnd: ThemePrimary.primaryColor,
        title: Text('Lịch sử chuyến'),
        actions: <Widget>[
          PopupMenuButton<CustomPopupMenu>(
            child: Container(
              child: Row(
                children: <Widget>[
                  Text(
                    viewModel.driver.vehicleName.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
//          elevation:  30.2,
            initialValue: viewModel.selectedVehicle,
            onSelected: _selectVehicle,
            itemBuilder: (BuildContext context) {
              return viewModel.choicesVehicle.map((CustomPopupMenu vehicle) {
                return PopupMenuItem<CustomPopupMenu>(
                  value: vehicle,
                  child: Text(vehicle.title.toString()),
                );
              }).toList();
            },
          )
        ],
      );
    }

    Widget _body() {
      return RefreshIndicator(
        onRefresh: () async {
          viewModel.onLoad();
        },
        child: viewModel.loading
            ? LoadingSpinner.loadingView(
                context: context, loading: viewModel.loading)
            : viewModel.listHistoryDriverBusSession.length > 0
                ? ListView(
                    controller: viewModel.controller,
                    children: <Widget>[
                      ...viewModel.listHistoryDriverBusSession
                          .map((historyDriver) => Column(
                                children: <Widget>[
                                  ...historyDriver.listHistory
                                      .asMap()
                                      .map(
                                        (index, driverBusSession) => MapEntry(
                                          index,
                                          _item(
                                            driverBusSession: driverBusSession,
                                            url: historyDriver
                                                .listUrlHistoryPositions[index],
                                            title: DateFormat('dd/MM/yyyy')
                                                .format(DateTime.parse(
                                                    historyDriver
                                                        .transportDate)),
                                            onTap: () {
                                              viewModel.onTapHistory(
                                                  driverBusSession);
                                            },
                                          ),
                                        ),
                                      )
                                      .values
                                      .toList()
                                ],
                              )),
                      if (viewModel.loadingMore)
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    ThemePrimary.primaryColor),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Đang tải dữ liệu ...',
                                style:
                                    TextStyle(color: ThemePrimary.primaryColor),
                              ),
                            ],
                          ),
                        ),
                    ],
                  )
                : SingleChildScrollView(
                    child: EmptyWidget(
                      message: 'Chưa có lịch sử di chuyển.',
                    ),
                  ),
//              ),
      );
    }

    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return TS24Scaffold(
              appBar: _appBar(),
              body: _body(),
            );
          }),
    );
  }
}
