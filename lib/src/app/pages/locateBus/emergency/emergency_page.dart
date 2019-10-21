import 'package:b2s_driver/src/app/widgets/ts24_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:polygon_clipper/polygon_border.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyPage extends StatelessWidget {
  static const String routeName = "/emergency";
  Widget _appBar() {
    return TS24AppBar(
      backgroundColorStart: Colors.red,
      backgroundColorEnd: Colors.yellow,
      title: Text(
        'KHẨN CẤP',
        textAlign: TextAlign.center,
      ),
    );
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
              onTap: (){
                launch('tel:113');
              },
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 30,
                      left: 58,
                      child: Container(
                        //color: Colors.yellow,
                        child: Image(
                          image:
                          AssetImage('assets/images/sheriff.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 90,
                      left: 70,
                      child: Text(
                        '113',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.orange),
                      ),
                    ),
                    Positioned(
                      top: 125,
                      left: 55,
                      child: Text(
                        'CÔNG AN',
                        style: TextStyle(fontSize: 16),
                      ),
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
              onTap: (){
                launch('tel:115');
              },
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 30,
                      left: 55,
                      child: Container(
                        //color: Colors.yellow,
                        child: Image(
                          image: AssetImage('assets/images/fire.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 90,
                      left: 70,
                      child: Text(
                        '115',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.orange),
                      ),
                    ),
                    Positioned(
                      top: 125,
                      left: 55,
                      child: Text(
                        'CỨU HỎA',
                        style: TextStyle(fontSize: 16),
                      ),
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
              onTap: (){
                launch('tel:114');
              },
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 33,
                      left: 60,
                      child: Container(
                        //color: Colors.yellow,
                        child: Image(
                          image: AssetImage(
                              'assets/images/ambulance.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 88,
                      left: 70,
                      child: Text(
                        '114',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.orange),
                      ),
                    ),
                    Positioned(
                      top: 125,
                      left: 40,
                      child: Text(
                        'CỨU THƯƠNG',
                        style: TextStyle(fontSize: 16),
                      ),
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Colors.deepOrange,
                    Colors.yellow,
                    Colors.deepOrange,
                    Colors.yellow,
                  ],
                ),
              ),
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
              //color: Colors.grey[700],
              height: 50,
              child: Text('THÔNG BÁO SỰ CỐ CHO PHỤ HUYNH & NHÀ TRƯỜNG'),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              alignment: Alignment.center,
              //color: Colors.orange[700],
              height: 50,
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
                color: Colors.grey[300],
//                border: Border.all(
//                    width: 1.5
//                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(25.0) //         <--- border radius here
                    ),
              ),
              child: Text(
                'Kẹt xe nghiêm trọng',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              alignment: Alignment.center,
              //color: Colors.orange[700],
              height: 50,
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
                color: Colors.grey[300],
//                border: Border.all(
//                    width: 1.5
//                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(25.0) //         <--- border radius here
                    ),
              ),
              child: Text(
                'Tai nạn giao thông',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              alignment: Alignment.center,
              //color: Colors.orange[700],
              height: 50,
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
                color: Colors.grey[300],
//                border: Border.all(
//                    width: 1.5
//                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(25.0) //         <--- border radius here
                    ),
              ),
              child: Text(
                'Học sinh bị ốm / nghỉ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
