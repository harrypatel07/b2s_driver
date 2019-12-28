import 'dart:ui';

import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/historyTripDetailPage/historyTrip_detail_viewmodel.dart';
import 'package:b2s_driver/src/app/service/common-service.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/dash.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:b2s_driver/src/app/widgets/ts24_button_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryTripDetailPage extends StatefulWidget {
  static const String routeName = "/historyDetailTrip";
  final DriverBusSession driverBusSession;
  const HistoryTripDetailPage({Key key, this.driverBusSession})
      : super(key: key);
  @override
  _HistoryTripDetailPageState createState() => _HistoryTripDetailPageState();
}

class _HistoryTripDetailPageState extends State<HistoryTripDetailPage> {
  HistoryTripDetailViewModel viewModel = HistoryTripDetailViewModel();
  GlobalKey _key = GlobalKey();
  Size _size = Size(0, 0);
  _getPosition() {
    final RenderBox renderBox = _key.currentContext.findRenderObject();
    _size = renderBox.size;
  }

  GlobalKey _keyContent = GlobalKey();
  Size _sizeContent = Size(0, 0);
  _getSizeContent() {
    final RenderBox renderBox = _keyContent.currentContext.findRenderObject();
    _sizeContent = renderBox.size;
  }

  bool lastStatus = true;

  _scrollListener() {
    print("HIEP:" + viewModel.scrollController.offset.toString());
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      viewModel.updateState();
    }
  }

  bool get isShrink {
    return viewModel.scrollController.hasClients &&
        (viewModel.scrollController.offset > (200 - kToolbarHeight));
  }

  final heightChildName = 35.0;
  final heightTitle = 44.0;
  final heightRouteName = 43.5;
  final heightLine = 1.0;
  final heightTable = 120.0;
  final heightMargin = 10.0;
  final listViewHeight = 60.0;
  @override
  void initState() {
    viewModel.scrollController = ScrollController();
    viewModel.scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
      viewModel.getUrlMaps(widget.driverBusSession);
      viewModel.getListPositions(widget.driverBusSession);
          _getPosition();
          _getSizeContent();
        }));
    super.initState();
  }

  @override
  void dispose() {
    viewModel.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _tablePickDrop(ChildDrenStatus childDrenStatus, int typeBus) {
      String __estimateStartTime =
          childDrenStatus.pickingRoute.startTime != '' &&
                  childDrenStatus.pickingRoute.startTime != null
              ? childDrenStatus.pickingRoute.startTime
              : '';
      String __estimateEndTime = childDrenStatus.pickingRoute.endTime != '' &&
              childDrenStatus.pickingRoute.endTime != null
          ? childDrenStatus.pickingRoute.endTime
          : '';
      String __realStartTime =
          childDrenStatus.pickingRoute.xRealStartTime != '' &&
                  childDrenStatus.pickingRoute.xRealStartTime != null
              ? childDrenStatus.pickingRoute.xRealStartTime
              : __estimateStartTime;
      String __realEndTime = childDrenStatus.pickingRoute.xRealEndTime != '' &&
              childDrenStatus.pickingRoute.xRealEndTime != null
          ? childDrenStatus.pickingRoute.xRealEndTime
          : __estimateEndTime;
      return Container(
          margin: EdgeInsets.fromLTRB(5, heightMargin, 5, 0),
//          color: Colors.pink,
          padding: EdgeInsets.all(5),
          height: heightTable,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 2),
                    color: Color(0x20000000),
                    blurRadius: 5),
                BoxShadow(
                    offset: Offset(2, 0),
                    color: Color(0x20000000),
                    blurRadius: 5),
              ]),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
                horizontalInside:
                    BorderSide(width: 1.0, color: Colors.grey[300])),
            children: [
              TableRow(children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Thời gian',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    'Đến trạm',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
              TableRow(children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Dự kiến',
                    textAlign: TextAlign.left,
                  ),
                ),
                Text(
                  Common.removeMiliSecond(
                      typeBus == 0 ? __estimateStartTime : __estimateEndTime),
                  textAlign: TextAlign.center,
                ),
              ]),
              TableRow(children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Thực tế',
                    textAlign: TextAlign.left,
                  ),
                ),
                Text(
                  Common.removeMiliSecond(
                      typeBus == 0 ? __realStartTime : __realEndTime),
                  textAlign: TextAlign.center,
                ),
              ]),
              TableRow(children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Chênh lệch',
                    textAlign: TextAlign.left,
                  ),
                ),
                typeBus == 0
                    ? Center(
                        child: Text(
                          (__estimateStartTime != '' && __realStartTime != '')
                              ? viewModel.getDifferenceTime(
                                  __estimateStartTime, __realStartTime)
                              : '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ThemePrimary.primaryColor),
                        ),
                      )
                    : Center(
                        child: Text(
                          (__estimateEndTime != '' && __realEndTime != '')
                              ? viewModel.getDifferenceTime(
                                  __estimateEndTime, __realEndTime)
                              : '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ThemePrimary.primaryColor),
                        ),
                      ),
              ])
            ],
          ));
    }

    Widget _item(
        {DriverBusSession driverBusSession, String title, Function onTap}) {
      Widget __listViewChildren(List<Children> listChildren, int indexRoute) {
        return Container(
          height: listViewHeight,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.fromLTRB(5, heightMargin, 5, 0),
          child: ListView.builder(
            itemCount: listChildren.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return TS24Button(
                width: listViewHeight,
                decoration: BoxDecoration(
//                        shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(25)),
                onTap: () {
                  viewModel.onTapChildren(
                      listChildren[index],
                      index.toString() +
                          listChildren[index].id.toString() +
                          indexRoute.toString());
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Hero(
                    tag: index.toString() +
                        listChildren[index].id.toString() +
                        indexRoute.toString(),
                    child: CachedNetworkImage(
                      imageUrl: listChildren[index].photo,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 35.0,
                        backgroundImage: imageProvider,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }

//      Widget __image() {
//        String url = GoogleMapService.getUrlImageFromMultiMarker(
//          width: (MediaQuery.of(context).size.width.toInt() - 40) * 2,
//          height: 170,
//          listLatLng: driverBusSession.listRouteBus
//              .map((route) => LatLng(route.lat, route.lng))
//              .toList(),
//        );
//
//        return Positioned(
//          top: 0,
//          left: 0,
//          right: 0,
//          child: Container(
////        color: Colors.orange,
//              height: 170 / 2 + 40,
//              width: MediaQuery.of(context).size.width,
//              child: CachedNetworkImage(
//                  imageUrl: url,
//                  imageBuilder: (context, imageProvider) => Image(
//                        image: imageProvider,
//                        fit: BoxFit.cover,
//                      ))),
//        );
//      }

      Widget __right() {
//        int countChild = 0;
        double widgetHeight = driverBusSession.childDrenRoute.length *
                (heightRouteName + heightLine + heightTable + heightMargin) +
//            countChild * heightChildName +
            30;
        driverBusSession.childDrenRoute.forEach((index) {
          widgetHeight += listViewHeight + heightMargin;
        });
        return Flexible(
          flex: 8,
          child: Container(
            key: _key,
            height: widgetHeight,
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
                  var listChildren = viewModel.getListChildrenForTimeLine(
                      driverBusSession, routeBusID);
                  var childDrenStatus = driverBusSession.childDrenStatus
                      .firstWhere((status) => status.routeBusID == routeBusID);
                  var listChildDrenStatus = driverBusSession.childDrenStatus
                      .where((status) => status.routeBusID == routeBusID)
                      .toList();
                  int countChildLeave = listChildDrenStatus
                      .where((childDrenStatus) => childDrenStatus.statusID == 3)
                      .toList()
                      .length;
                  int countChildPick = listChildDrenStatus
                      .where((childDrenStatus) =>
                          childDrenStatus.statusID != 3 &&
                          childDrenStatus.typePickDrop == 0)
                      .toList()
                      .length;
                  int countChildDrop = listChildDrenStatus
                      .where((childDrenStatus) =>
                          childDrenStatus.statusID != 3 &&
                          childDrenStatus.typePickDrop == 1)
                      .toList()
                      .length;
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: heightRouteName,
                                          child: Text(
                                            routeBus.routeName,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.arrow_upward,
                                              color: Colors.green,
                                            ),
                                            Text(countChildPick.toString()),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.arrow_downward,
                                              color: Colors.yellow[700],
                                            ),
                                            Text(countChildDrop.toString()),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.home,
                                              color: Colors.red,
                                            ),
                                            Text(countChildLeave.toString())
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: heightLine,
                                    color: Colors.grey[500],
                                  ),
                                  if (childDrenStatus != null)
                                    _tablePickDrop(
                                        childDrenStatus, driverBusSession.type),
                                  __listViewChildren(listChildren, index),
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
            height: _size.height,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: driverBusSession.childDrenRoute.length,
              itemBuilder: (context, index) {
                return new LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  double ___heightDash = 0;
                  if (index > 0) {
                    ___heightDash = heightLine +
                        heightTable +
                        heightMargin +
                        heightRouteName * 0.6;
                    ___heightDash += listViewHeight + heightMargin;
                  }
                  return Container(
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
                              : Dash(
                                  length: ___heightDash,
                                  dashLength: 2,
                                  direction: Axis.vertical,
                                  dashColor: ThemePrimary.primaryColor,
                                  dashThickness: 1,
                                ),
                          (index == 0)
                              ? Transform.rotate(
                                  angle: 3.14,
                                  child: Icon(
                                    Icons.navigation,
                                    color: ThemePrimary.primaryColor,
                                  ),
                                )
                              : Icon(
                                  Icons.radio_button_unchecked,
                                  color: Colors.orange,
                                  size: 15,
                                ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        );
      }

      Widget __content() {
        return Container(
          key: _keyContent,
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

      return Container(
//        margin: EdgeInsets.only(top: 100),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
//            __image(),
            Column(
              children: <Widget>[
//                SizedBox(
//                  height: 170 / 2 + 40,
//                ),
                __content(),
//                        __buttonSupport(),
              ],
            ),
          ],
        ),
      );
    }

//    Widget _appBar() {
//      return TS24AppBar(
//        backgroundColorStart: ThemePrimary.primaryColor,
//        backgroundColorEnd: ThemePrimary.primaryColor,
//        title: Text('Chi tiết lịch sử chuyến'),
//        leading: IconButton(
//          icon: Icon(Icons.arrow_back),
//          onPressed: () => Navigator.pop(context),
//        ),
//      );
//    }

    Widget _body() {
      return _item(
          driverBusSession: widget.driverBusSession,
          title: DateFormat('dd/MM/yyyy').format(
              DateTime.parse(widget.driverBusSession.listRouteBus[0].date)),
          onTap: () {});
    }

    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return TS24Scaffold(
              body: CustomScrollView(
                controller: viewModel.scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    iconTheme: IconThemeData(
                        color: isShrink ? Colors.white : Colors.black54),
                    expandedHeight: 200.0,
//                    floating: true,
                    pinned: true,
//                    snap: true,
                    elevation: 50,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text("Chi tiết lịch sử chuyến",
                            style: TextStyle(
                                color: isShrink
                                    ? Colors.white
                                    : Colors.transparent,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold)),
                        background: InkWell(
                          onTap: (){
                            viewModel.onTapMaps(widget.driverBusSession.listRouteBus);
                          },
                          child: CachedNetworkImage(
                              imageUrl: viewModel.urlMaps,
                              imageBuilder: (context, imageProvider) => Image(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              )),
                        )),
                  ),
                  new SliverList(
                      delegate: new SliverChildListDelegate([_body()])),
                ],
              ),
            );
          }),
    );
  }
}
