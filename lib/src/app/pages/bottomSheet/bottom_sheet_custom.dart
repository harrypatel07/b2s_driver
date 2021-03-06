import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/bottom_sheet_viewmodel_abstract.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/models/statusBus.dart';
import 'package:b2s_driver/src/app/pages/bottomSheet/bottom_sheet_custom_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/home/profile_children/profile_children.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/timeline_widget.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:b2s_driver/src/app/widgets/ts24_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef CallbackUpdateLocation = void Function(bool changed);
class BottomSheetCustom extends StatefulWidget {
  static const String routeName = "/bottomsheetcustom";
  final BottomSheetCustomArgs arguments;
  final CallbackUpdateLocation callbackUpdateLocation;
  const BottomSheetCustom(
      {Key key, this.arguments, this.callbackUpdateLocation})
      : super(key: key);
  @override
  _BottomSheetCustomState createState() => _BottomSheetCustomState();
}

class BottomSheetCustomArgs {
  final BottomSheetViewModelBase viewModel;
  BottomSheetCustomArgs({this.viewModel});
}

class _BottomSheetCustomState extends State<BottomSheetCustom> {
  BottomSheetCustomViewModel viewModel = BottomSheetCustomViewModel();
  @override
  void initState() {
    viewModel.bottomSheetViewModelBase = widget.arguments.viewModel;
    viewModel.listenData();
    super.initState();
  }

  List<TimeLineEvent> _buildListTimeLine(
      DriverBusSession driverBusSession, RouteBus routeBus) {
    var index = 0;
    return List()
      ..add(TimeLineEvent(
          time: routeBus.time,
          task: routeBus.routeName,
          content: viewModel
              .getListChildrenForTimeLine(driverBusSession, routeBus.id)
              .map((children) {
            index++;
            var status = ChildDrenStatus.getStatusByChildrenID(
                driverBusSession.childDrenStatus, children.id, routeBus.id);
            viewModel.listChildrenStatus.add(status);
            final statusBus =
                StatusBus.getStatusByID(StatusBus.list, status.statusID);
            var tag = children.id.toString() +
                routeBus.id.toString() +
                driverBusSession.busID.toString() +
                index.toString();
            return HomePageCardTimeLine(
                children: children,
                //isEnablePicked: status.statusID == 0 ? true : false,
                status: statusBus,
                note: status.note,
                isDriver: viewModel.driver.isDriver,
                isPickDrop: viewModel.driver.checkPickDrop,
                heroTag: tag,
                typePickDrop: status.typePickDrop,
                isEnableTapChildrenContentCard: true,
                cardType: 1,
                onTapPickUp: () {
                  viewModel.onTapPickUpLocateBus(
                      driverBusSession, children, routeBus);
                },
                onTapChangeStatusLeave: () {
                  viewModel.onTapLeave(driverBusSession, children, routeBus);
                },
                onTapShowChildrenProfile: () {
                  Navigator.pushNamed(context, ProfileChildrenPage.routeName,
                      arguments: ProfileChildrenArgs(
                          children: children, heroTag: tag));
                },
                onTapScan: () {
                  viewModel.onTapScanQRCode(
                      driverBusSession, children, routeBus);
                });
          }).toList(),
          isFinish: routeBus.status));
  }

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
            child: Container(
              decoration: BoxDecoration(
                  color: ThemePrimary.primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18.0),
                      topLeft: Radius.circular(18.0))),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 1, right: 1),
                    height: MediaQuery.of(context).size.height * 3 / 4,
                    color: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: Text(
                            'THÔNG TIN ĐIỂM ${viewModel.bottomSheetViewModelBase.position}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
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
                                    viewModel.bottomSheetViewModelBase
                                        .driverBusSession,
                                    viewModel
                                        .bottomSheetViewModelBase.routeBus),
                                position:
                                    viewModel.bottomSheetViewModelBase.position,
                                atPageHome: false,
                              )),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: TS24Button(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3.0,
                              spreadRadius: 0.5,
                              offset: Offset(
                                3.0,
                                3.0,
                              ),
                            ),
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3.0,
                              spreadRadius: 0.5,
                              offset: Offset(
                                -3.0,
                                0.0,
                              ),
                            )
                          ]),
                      onTap: () {
                        viewModel
                            .onTapUpdateLocation(widget.callbackUpdateLocation);
                      },
                      child: Center(
                          child: Icon(
                        Icons.adjust,
                        color: ThemePrimary.primaryColor,
                      )),
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    right: 2,
                    left: 2,
                    child: SafeArea(
                      bottom: true,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius:
                                  2.0, // has the effect of softening the shadow
                              spreadRadius:
                                  1.0, // has the effect of extending the shadow
                              offset: Offset(
                                2.0, // horizontal, move right 10
                                2.0, // vertical, move down 10
                              ),
                            )
                          ],
                          color: (viewModel
                                  .bottomSheetViewModelBase.routeBus.status)
                              ? Colors.grey
                              : ThemePrimary.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(
                                  25.0) //         <--- border radius here
                              ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            onTap: () {
                              viewModel.onTapFinishRoute();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              //color: Colors.orange[700],
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                        25.0) //         <--- border radius here
                                    ),
                              ),
                              child: (viewModel
                                      .bottomSheetViewModelBase.routeBus.status)
                                  ? Text('ĐÃ HOÀN THÀNH',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))
                                  : Text(
                                      'HOÀN THÀNH ĐIỂM ${viewModel.bottomSheetViewModelBase.position}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
