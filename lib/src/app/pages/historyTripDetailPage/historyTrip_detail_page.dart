import 'dart:ui';

import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/historyTripDetailPage/historyTrip_detail_viewmodel.dart';
import 'package:b2s_driver/src/app/service/googlemap-service.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/dash.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  ScrollController _scrollController;

  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
        lastStatus = isShrink;
        viewModel.updateState();
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        (_scrollController.offset > (200 - kToolbarHeight));
  }
  final heightChildName = 35.0;
  final heightTitle = 44.0;
  final heightRouteName = 43.5;
  final heightLine = 1.0;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
      _getPosition();
    }));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Widget _item(
        {DriverBusSession driverBusSession, String title, Function onTap}) {
      Widget __image() {
        String url = GoogleMapService.getUrlImageFromMultiMarker(
          width: (MediaQuery.of(context).size.width.toInt() - 40) * 2,
          height: 170,
          listLatLng: driverBusSession.listRouteBus
              .map((route) => LatLng(route.lat, route.lng))
              .toList(),
        );

        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
//        color: Colors.orange,
              height: 170 / 2 + 40,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                  imageUrl: url,
                  imageBuilder: (context, imageProvider) => Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ))),
        );
      }

      Widget __right() {
        int countChild = 0;
        driverBusSession.childDrenRoute.forEach((index) {
          countChild += index.listChildrenID.length;
        });
        double widgetHeight =
            driverBusSession.childDrenRoute.length * heightRouteName +
                countChild * heightChildName +
                driverBusSession.childDrenRoute.length * heightLine +
                20;
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
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
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
                                            Text('10'),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.arrow_downward,
                                              color: Colors.yellow[700],
                                            ),
                                            Text('10'),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                            ),
                                            Text('0')
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: heightLine,
                                    color: Colors.grey[500],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ...listChildren
                                            .map((child) => Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: heightChildName,
                                                  child: Text(child.name),
                                                )),
                                      ],
                                    ),
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
            height: _size.height,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: driverBusSession.childDrenRoute.length,
              itemBuilder: (context, index) {
                return new LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
//                  int heightDash = ;
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
                                  length: driverBusSession
                                              .childDrenRoute[index - 1]
                                              .listChildrenID
                                              .length *
                                          heightChildName +
                                      heightLine +
                                      heightRouteName * 0.6,
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

    Widget _appBar() {
      return TS24AppBar(
        backgroundColorStart: ThemePrimary.primaryColor,
        backgroundColorEnd: ThemePrimary.primaryColor,
        title: Text('Chi tiết lịch sử chuyến'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      );
    }

    Widget _body() {
      return _item(
          driverBusSession: widget.driverBusSession,
          title: widget.driverBusSession.listRouteBus[0].date,
          onTap: () {});
    }

    viewModel.context = context;
    viewModel.getUrlMaps(widget.driverBusSession);
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return TS24Scaffold(
//              appBar: _appBar(),
              body: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      iconTheme: IconThemeData(color: isShrink ? Colors.white : Colors.black54),
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text("Chi tiết lịch sử chuyến",
                              style: TextStyle(
                                color: isShrink ? Colors.white : Colors.transparent,
                                fontSize: 16.0,
                              )),
                          background: CachedNetworkImage(
                              imageUrl: viewModel.urlMaps,
                              imageBuilder: (context, imageProvider) => Image(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ))),
                    ),
                  ];
                },
                body: _body(),
              ),
              // _body(),
            );
          }),
    );
  }
}
