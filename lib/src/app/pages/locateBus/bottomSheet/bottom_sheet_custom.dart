import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/models/statusBus.dart';
import 'package:b2s_driver/src/app/pages/home/profile_children/profile_children.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/timeline_widget.dart';
import 'package:b2s_driver/src/app/pages/locateBus/bottomSheet/bottom_sheet_custom_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:flutter/material.dart';

class BottomSheetCustom extends StatefulWidget {
  static const String routeName = "/bottomsheetcustom";
  final BottomSheetCustomArgs arguments;

  const BottomSheetCustom({Key key, this.arguments}) : super(key: key);
  @override
  _BottomSheetCustomState createState() => _BottomSheetCustomState();
}

class BottomSheetCustomArgs {
  final LocateBusPageViewModel viewModel;
  BottomSheetCustomArgs({this.viewModel});
}

class _BottomSheetCustomState extends State<BottomSheetCustom> {
  BottomSheetCustomViewModel viewModel = BottomSheetCustomViewModel();
  @override
  void initState() {
    super.initState();
  }

  List<TimeLineEvent> _buildListTimeLine(
      DriverBusSession driverBusSession, RouteBus routeBus) {
    return List()
      ..add(TimeLineEvent(
          time: routeBus.time,
          task: routeBus.routeName,
          content: viewModel
              .getListChildrenForTimeLine(driverBusSession, routeBus.id)
              .map((children) {
            final status = ChildDrenStatus.getStatusByChildrenID(
                driverBusSession.childDrenStatus, children.id, routeBus.id);
            final statusBus = StatusBus.getStatusByID(StatusBus.list, status.statusID);
            var tag = children.id.toString() +
                routeBus.id.toString() +
                driverBusSession.busID.toString();
            return HomePageCardTimeLine(
              children: children,
              isEnablePicked: status.statusID == 0 ? true : false,
              status: statusBus,
              isEnableTapChildrenContentCard: true,
              heroTag: tag,
              typePickDrop: status.typePickDrop,
              cardType: 1,
              onTapPickUp: () {
                viewModel.onTapPickUpLocateBus(
                    driverBusSession, children, routeBus);
              },
              onTapChangeStatusLeave: () {
//              onTapChangeChildrenStatus(
//                  driverBusSession, children, routeBus, 3);
//              print("show button call");
              },
              onTapShowChildrenProfile: () {
                Navigator.pushNamed(context, ProfileChildrenPage.routeName,
                    arguments:
                        ProfileChildrenArgs(children: children, heroTag: tag));
              },
            );
          }).toList(),
          isFinish: routeBus.status));
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    viewModel.localBusViewModel = widget.arguments.viewModel;
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
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18.0),
                              topLeft: Radius.circular(18.0))),
                      padding: EdgeInsets.only(top: 10),
                      margin: EdgeInsets.only(right: 2, left: 2),
                      child: HomePageTimeLineV2(
                        listTimeLine: _buildListTimeLine(
                            viewModel.localBusViewModel.driverBusSession,
                            viewModel.localBusViewModel.routeBus),
                        position: viewModel.localBusViewModel.position,
                      )),
                ),
                Positioned(
                    bottom: -5,
                    right: 2,
                    left: 2,
                    child: FlatButton(
                      color: ThemePrimary.primaryColor,
                      child: Text(
                        'HOÀN THÀNH',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}