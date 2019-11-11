import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  static const String routeName = "/schedule";
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: IconButton(
            icon: Icon(Icons.access_alarm),
            onPressed: () {
              // Driver driver = Driver();
              // api.getListDriverBusSession(
              //   vehicleId: driver.listVehicle[0].id,
              //   driverId: driver.id,
              // );
              Navigator.pushNamed(context, HomePage.routeName);
              print("navigate");
            }),
      ),
    );
  }
}
