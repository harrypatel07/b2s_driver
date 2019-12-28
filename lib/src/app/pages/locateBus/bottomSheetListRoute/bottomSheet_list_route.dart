import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/pages/bottomSheet/bottom_sheet_custom.dart';
import 'package:b2s_driver/src/app/pages/locateBus/bottomSheetListRoute/bottomSheet_list_route_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/listview_card_widget.dart';

import 'package:flutter/material.dart';

class BottomSheetListRoute extends StatefulWidget {
  static const String routeName = '/bottomSheetListRoute';
  final BottomSheetCustomArgs arguments;

  const BottomSheetListRoute({Key key, this.arguments}) : super(key: key);
  @override
  _BottomSheetListRouteState createState() => _BottomSheetListRouteState();
}

class _BottomSheetListRouteState extends State<BottomSheetListRoute> {
  BottomSheetListRouteVieModel viewModel = BottomSheetListRouteVieModel();
  @override
  void initState() {
    viewModel.bottomSheetViewModelBase = widget.arguments.viewModel;
    viewModel.listenData();
    super.initState();
  }

//  List<TimeLineEvent> _buildListTimeLine(DriverBusSession driverBusSession) {
////    var index = 0;
//    return driverBusSession.listRouteBus
//        .asMap()
//        .map((index, routeBus) => MapEntry(
//            index,
//            TimeLineEvent(
//                colorDefault: Colors.black,
//                colorFinish: Colors.black12,
//                onTap: () {
//                  viewModel.onTap(index + 1);
//                  print("Hiep ${routeBus.routeName}");
//                },
//                time: routeBus.time,
//                task: routeBus.routeName,
//                content: [],
//                isFinish: routeBus.status)))
//        .values
//        .toList();
//  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 3 / 4,
                  color: Colors.transparent,
                  child: Container(
                      decoration: BoxDecoration(
                          color: ThemePrimary.primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18.0),
                              topLeft: Radius.circular(18.0))),
//                      padding: EdgeInsets.only(top: 10),
                      margin: EdgeInsets.only(right: 1, left: 1),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: Text(
                              'DANH SÁCH ĐIỂM',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 2, right: 2),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(18.0),
                                      topLeft: Radius.circular(18.0))),
                              child: ListView(
                                  children: viewModel.bottomSheetViewModelBase
                                      .driverBusSession.listRouteBus
                                      .asMap()
                                      .map((index, routeBus) => MapEntry(
                                            index,
                                            ListViewCard(
                                              viewModel
                                                  .bottomSheetViewModelBase
                                                  .driverBusSession
                                                  .listRouteBus,
                                              index,
                                              Key('$index'),
                                              onTap: () {
                                                viewModel.onTap(index);
                                              },
                                              isShowTime: true,
                                            ),
                                          ))
                                      .values
                                      .toList()),
                            ),
                          )
                        ],
                      )
//                      HomePageTimeLineV2(
//                        listTimeLine: _buildListTimeLine(viewModel
//                            .bottomSheetViewModelBase.driverBusSession),
//                        atPageHome: false,
//                      )
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
