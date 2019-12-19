import 'package:b2s_driver/src/app/models/driverBusSession.dart';

class HistoryDriver {
  dynamic transportDate;
  List<String> listUrlHistoryPositions;
  List<DriverBusSession> listHistory;
  HistoryDriver(
      {this.transportDate, this.listHistory, this.listUrlHistoryPositions});
}
