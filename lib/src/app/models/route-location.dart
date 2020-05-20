import 'package:b2s_driver/src/app/models/routeBus.dart';

class RouteLocation {
  dynamic sLastUpdate;
  dynamic createDate;
  dynamic createUid;
  dynamic displayName;
  dynamic id;
  dynamic name;
  dynamic routeLocationHoliday;
  dynamic writeDate;
  dynamic writeUid;
  dynamic xCheckSchool;
  dynamic xManagerSchool;
  dynamic xPosx;
  dynamic xPosy;
  dynamic xPosz;
  dynamic xSaturday;
  dynamic xSunday;

  RouteLocation(
      {this.sLastUpdate,
      this.createDate,
      this.createUid,
      this.displayName,
      this.id,
      this.name,
      this.routeLocationHoliday,
      this.writeDate,
      this.writeUid,
      this.xCheckSchool,
      this.xManagerSchool,
      this.xPosx,
      this.xPosy,
      this.xPosz,
      this.xSaturday,
      this.xSunday});

  RouteLocation.fromRouteBus(RouteBus routeBus) {
    id = routeBus.id;
    xPosx = routeBus.lat;
    xPosy = routeBus.lng;
  }
  RouteLocation.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    createDate = json['create_date'];
    createUid = json['create_uid'];
    displayName = json['display_name'];
    id = json['id'];
    name = json['name'];
    routeLocationHoliday = json['route_location_holiday'];
    writeDate = json['write_date'];
    writeUid = json['write_uid'];
    xCheckSchool = json['x_check_school'];
    xManagerSchool = json['x_manager_school'];
    xPosx = json['x_posx'];
    xPosy = json['x_posy'];
    xPosz = json['x_posz'];
    xSaturday = json['x_saturday'];
    xSunday = json['x_sunday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__last_update'] = this.sLastUpdate;
    data['create_date'] = this.createDate;
    data['create_uid'] = this.createUid;
    data['display_name'] = this.displayName;
    data['id'] = this.id;
    data['name'] = this.name;
    data['route_location_holiday'] = this.routeLocationHoliday;
    data['write_date'] = this.writeDate;
    data['write_uid'] = this.writeUid;
    data['x_check_school'] = this.xCheckSchool;
    data['x_manager_school'] = this.xManagerSchool;
    data['x_posx'] = this.xPosx;
    data['x_posy'] = this.xPosy;
    data['x_posz'] = this.xPosz;
    data['x_saturday'] = this.xSaturday;
    data['x_sunday'] = this.xSunday;
    return data;
  }

  Map<String, dynamic> toJsonUpdateCoord() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['x_posx'] = this.xPosx;
    data['x_posy'] = this.xPosy;
    return data;
  }
}
