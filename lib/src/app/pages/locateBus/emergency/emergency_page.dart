import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/locateBus/bottomSheetListChildrenEmergency/bottomSheet_listChildren_emergency.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:b2s_driver/src/app/widgets/popup_emergency_widget.dart';
import 'package:b2s_driver/src/app/widgets/ts24_appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:intent/action.dart' as prefix0;
//import 'package:intent/action.dart' as prefix0;
//import 'package:polygon_clipper/polygon_border.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:intent/intent.dart' as intent;
//import 'package:intent/action.dart';
//import 'package:intent/extra.dart';
//import 'package:intent/category.dart';
//import 'package:intent/flag.dart';

class EmergencyPage extends StatelessWidget {
  static const String routeName = "/emergency";
  final DriverBusSession driverBusSession;
  const EmergencyPage({Key key, this.driverBusSession}) : super(key: key);
  Widget _appBar() {
    return TS24AppBar(
      backgroundColorStart: ThemePrimary.primaryColor,
      backgroundColorEnd: ThemePrimary.primaryColor,
      title: Text(
        'KHẨN CẤP',
        textAlign: TextAlign.center,
      ),
    );
  }

  void onTapCall(String phoneNumber) {
    launch('tel:$phoneNumber');
//    intent.Intent()
//      ..setAction(prefix0.Action.ACTION_CALL)
//      ..setData(Uri(scheme: "tel", path: phoneNumber))
//      ..startActivity().catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBody() {
      final __policeButton = Positioned(
        top: 5,
        left: MediaQuery.of(context).size.width / 2 - 90,
        child: Container(
          width: 180,
          height: 180,
          child: ClipPolygon(
            sides: 6,
            borderRadius: 5.0, // Default 0.0 degrees
            //rotate: 90.0, // Default 0.0 degrees
            boxShadows: [
              //PolygonBoxShadow(color: Colors.red, elevation: 5.0),
              PolygonBoxShadow(color: Colors.black, elevation: 5.0)
            ],
            child: InkWell(
              onTap: () {
                onTapCall("113");
              },
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '113',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: ThemePrimary.primaryColor),
                    ),
                    Text(
                      'CÔNG AN',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      final __fireFightButton = Positioned(
        top: 149,
        right: MediaQuery.of(context).size.width / 2 - 7,
        child: Container(
          width: 180,
          height: 180,
          child: ClipPolygon(
            sides: 6,
            borderRadius: 5.0, // Default 0.0 degrees
            //rotate: 90.0, // Default 0.0 degrees
            boxShadows: [
              //PolygonBoxShadow(color: Colors.red, elevation: 1.0),
              PolygonBoxShadow(color: Colors.black, elevation: 5.0)
            ],
            child: InkWell(
              onTap: () {
                onTapCall("115");
              },
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '115',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: ThemePrimary.primaryColor),
                    ),
                    Text(
                      'CỨU HỎA',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      final __ambulance = Positioned(
        top: 149,
        left: MediaQuery.of(context).size.width / 2 - 7,
        child: Container(
          width: 180,
          height: 180,
          child: ClipPolygon(
            sides: 6,
            borderRadius: 5.0, // Default 0.0 degrees
            //rotate: 90.0, // Default 0.0 degrees
            boxShadows: [
              //PolygonBoxShadow(color: Colors.red, elevation: 1.0),
              PolygonBoxShadow(color: Colors.black, elevation: 5.0)
            ],
            child: InkWell(
              onTap: () {
                onTapCall("114");
              },
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '114',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: ThemePrimary.primaryColor),
                    ),
                    Text(
                      'CỨU THƯƠNG',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              //color: Colors.grey[300],
              height: 345,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.grey[200]),
              //color: Colors.red,
              child: Stack(
                children: <Widget>[
                  __policeButton,
                  __fireFightButton,
                  __ambulance
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10, right: 10),
              //color: Colors.grey[700],
              height: 50,
              child: Text(
                'THÔNG BÁO SỰ CỐ CHO PHỤ HUYNH & NHÀ TRƯỜNG',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                    api.postNotificationProblem(
                        driverBusSession.listChildren, 0);
                    Future.delayed(Duration(milliseconds: 300)).then((_) {
                      LoadingDialog().showMsgDialogWithCloseButton(
                          context, "Đã gủi tin thành công.");
                    });
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
                      'Kẹt xe nghiêm trọng',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                    api.postNotificationProblem(
                        driverBusSession.listChildren, 1);
                    Future.delayed(Duration(milliseconds: 300)).then((_) {
                      LoadingDialog().showMsgDialogWithCloseButton(
                          context, "Đã gửi tin thành công.");
                    });
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
                      'Tai nạn giao thông',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext bc) {
                          return BottomSheetListChildrenEmergency(
                            driverBusSession: driverBusSession,
                          );
                        });
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
                      'Học sinh cấp cứu',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext bc) {
                          return PopupEmergencyWidget(
                            onTap: (message) {
                              api.postNotificationProblem(
                                  driverBusSession.listChildren, 3,
                                  content: message);
                              Future.delayed(Duration(milliseconds: 300))
                                  .then((_) {
                                LoadingDialog().showMsgDialogWithCloseButton(
                                    context, "Đã gửi tin thành công.");
                              });
                            },
                          );
                        });
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
                      'Sự cố khác',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // TODO: implement build
    return Scaffold(
      appBar: _appBar(),
      body: _buildBody(),
    );
  }
}
