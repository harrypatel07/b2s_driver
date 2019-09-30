import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  static const String routeName = "/history";
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new TS24AppBar(
        title: new Text("Trips"),
        leading: appBarIconSideMenu(context),
      ),
      backgroundColor: ThemePrimary.history_page_backgroundcolor,
      body: _buildBody(),
      // drawer: SideMenuPage(),
    );
  }

  Widget _buildBody() {
    Widget _buildLeftSection(HistoryInfo historyInfo) {
      return Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Container(
          width: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                historyInfo.dayName,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    letterSpacing: -1),
              ),
              Text(
                historyInfo.day,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                historyInfo.month,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildSeparator({Color color}) {
      if (color == null) color = Color(0XFF626368);
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashWidth = 3.0;
          final dashHeight = 0.5;
          final dashCount = (boxWidth / (2 * dashWidth)).floor();
          return Row(
            children: <Widget>[
              Expanded(
                child: Flex(
                  children: List.generate(dashCount, (_) {
                    return SizedBox(
                      width: dashWidth,
                      height: dashHeight,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black45),
                      ),
                    );
                  }),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  direction: Axis.horizontal,
                ),
              ),
              Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: Color(0xFFEDEEF2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFDDDDDD), width: 1.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DecoratedBox(
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                  ))
            ],
          );
        },
      );
    }

    /// type: 0 or 1.0 = đi, 1 = về
    Widget _buildRightSection(HistoryInfo historyInfo) {
      return Card(
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(4.0),
        // ),
        // padding: EdgeInsets.only(top: 0),
        elevation: 2,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "ĐÓN",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black12,
                    ),
                  ),
                  Expanded(flex: 6, child: Container()),
                  Text(
                    "THẢ",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black12,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    historyInfo.timePickup,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(flex: 6, child: Container()),
                  Text(
                    historyInfo.timeDrop,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text(historyInfo.type == 0 ? "Nhà" : "Trường",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      )),
                  Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: _buildSeparator(color: historyInfo.colorCircle),
                      )),
                  Text(historyInfo.type == 0 ? "Trường" : "Nhà",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ))
                ],
              ),
              Row(
                children: <Widget>[
                  Text(historyInfo.name,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9B9A9F),
                      )),
                  Expanded(flex: 6, child: Container()),
                  Text(historyInfo.type == 0 ? "Nhà" : "Trường",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9B9A9F),
                      ))
                ],
              ),
            ],
          ),
        ),
      );
    }

    ///type: 0 or 1.0 = đi, 1 = về
    Widget _listItem(List<HistoryInfo> listHistoryInfo) {
      return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildLeftSection(listHistoryInfo[0]),
            Expanded(
                flex: 8,
                child: Column(
                  children: <Widget>[
                    ...listHistoryInfo
                        .map((historyInfo) => _buildRightSection(historyInfo))
                        .toList(),
                  ],
                ))
          ],
        ),
      );
    }

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: _listItem([
            HistoryInfo(
                type: 0,
                name: "Luân",
                timePickup: "07:00 AM",
                timeDrop: "07:00 AM",
                day: "25",
                dayName: "Thứ 2",
                //colorCircle: Color(0xffFFD752),
                month: "Tháng 09"),
            HistoryInfo(
                type: 1,
                name: "Luân",
                timePickup: "16:00 PM",
                timeDrop: "16:30 PM",
                day: "25",
                dayName: "Thứ 2",
                month: "Tháng 09"),
          ]),
        ),
        _listItem([
          HistoryInfo(
              type: 0,
              name: "Luân",
              timePickup: "07:00 AM",
              timeDrop: "07:00 AM",
              day: "26",
              dayName: "Thứ 3",
              month: "Tháng 09"),
          HistoryInfo(
              type: 1,
              name: "Luân",
              timePickup: "16:00 PM",
              timeDrop: "17:00 PM",
              day: "26",
              dayName: "Thứ 3",
              month: "Tháng 09"),
        ]),
        _listItem([
          HistoryInfo(
              type: 0,
              name: "Luân",
              timePickup: "07:00 AM",
              timeDrop: "07:00 AM",
              day: "27",
              dayName: "Thứ 4",
              month: "Tháng 09"),
        ]),
      ],
    );
  }
}

class HistoryInfo {
  /// type: 0 or 1.0 = đi, 1 = về
  int type = 0;
  String name;
  String timePickup;
  String timeDrop;
  String day;
  String month;
  String dayName;
  Color colorCircle;
  HistoryInfo(
      {this.type,
      this.name,
      this.timePickup,
      this.timeDrop,
      this.day,
      this.month,
      this.dayName,
      this.colorCircle});
}
