import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/statusBus.dart';
import 'package:b2s_driver/src/app/pages/locateBus/bottomSheetListChildrenEmergency/bottomSheet_listChildren_emergency_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:flutter/material.dart';

class BottomSheetListChildrenEmergency extends StatefulWidget {
  static const String routeName = '/bottomSheetEmergency';
  final DriverBusSession driverBusSession;
  const BottomSheetListChildrenEmergency({Key key, this.driverBusSession})
      : super(key: key);
  @override
  _BottomSheetListChildrenEmergencyState createState() =>
      _BottomSheetListChildrenEmergencyState();
}

class _BottomSheetListChildrenEmergencyState
    extends State<BottomSheetListChildrenEmergency> {
  BottomSheetListChildrenEmergencyViewModel viewModel =
      BottomSheetListChildrenEmergencyViewModel();
  @override
  void initState() {
    viewModel.driverBusSession = widget.driverBusSession;
    viewModel.initListChildrenWithSelect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _body() {
      return Stack(
        children: <Widget>[
          Container(
//        padding: EdgeInsets.fromLTRB(8, 0, 10, 0),
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: ThemePrimary.primaryColor,
              borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(18), topRight: Radius.circular(18)),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                    'CHỌN HỌC SINH CẤP CỨU',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10,left: 5,right: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18)),
                    ),
                    child: ListView(
                      children: <Widget>[
                        ...viewModel.listChildrenWithSelect
                            .map((item) => HomePageCardTimeLine(
                                  children: item.children,
                                  isEnablePicked: false,
                                  status: StatusBus.list[0],
                                  heroTag: item.children.id.toString(),
                                  typePickDrop: 0,
                                  selected: item.isSelect,
                                  onChangeSelect: () {
                                    viewModel.onChangeSelect(item);
                                  },
                                  onTapShowChildrenProfile: () {
                                    viewModel.onTapShowChildrenProfile(
                                        item.children,
                                        item.children.id.toString());
                                  },
                                ))
                            .toList(),
                        SizedBox(
                          height: 55,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 1,
            left: 15,
            right: 15,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0, // has the effect of softening the shadow
                    spreadRadius: 1.0, // has the effect of extending the shadow
                    offset: Offset(
                      2.0, // horizontal, move right 10
                      2.0, // vertical, move down 10
                    ),
                  )
                ],
                color: ThemePrimary.primaryColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(25.0) //         <--- border radius here
                    ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  onTap: () {
                    viewModel.onSendListChildrenSOS();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    //color: Colors.orange[700],
                    height: 50,
                    decoration: BoxDecoration(
//                      color: ThemePrimary.primaryColor,
//                border: Border.all(
//                    width: 1.5
//                ),
                      borderRadius: BorderRadius.all(Radius.circular(
                              25.0) //         <--- border radius here
                          ),
                    ),
                    child: Text(
                      'Gửi thông tin cấp cứu',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return Material(
            color: Colors.transparent,
            child: _body(),
          );
        },
      ),
    );
  }
}
