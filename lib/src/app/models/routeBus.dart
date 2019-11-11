class RouteBus {
  dynamic id; //map với route location
  String date;
  String time;
  String routeName;
  int type; //0: lượt đi, //1: lượt về
  dynamic status; // hoàn thành
  double lat;
  double lng;
  bool isSchool;
  RouteBus({
    this.id,
    this.date,
    this.time,
    this.routeName,
    this.type,
    this.status,
    this.lat,
    this.lng,
    this.isSchool,
  });

  RouteBus.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    routeName = json['routeName'];
    type = json['type'];
    status = json['status'];
    lat = json['lat'];
    lng = json['lng'];
    isSchool = json['isSchool'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["date"] = this.date;
    data["time"] = this.time;
    data["routeName"] = this.routeName;
    data["type"] = this.type;
    data["status"] = this.status;
    data["lat"] = this.lat;
    data["lng"] = this.lng;
    data["isSchool"] = this.isSchool;
    return data;
  }

  static List<RouteBus> list = [
    RouteBus(
      id: 1,
      date: "2019-09-09",
      time: "07:00 am",
      routeName: "200 võ thị sáu, p10, q3",
      type: 0,
      status: true,
      lat: 10.784144,
      lng: 106.687781,
    ),
    RouteBus(
      id: 2,
      date: "2019-09-09",
      time: "07:10 am",
      routeName: "285/94B cách mạng tháng tám, p12, q10",
      type: 0,
      status: true,
      lat: 10.776573,
      lng: 106.685157,
    ),
    RouteBus(
      id: 3,
      date: "2019-09-09",
      time: "07:30 am",
      routeName: "Trường quốc tế việt úc",
      type: 0,
      status: false,
      lat: 10.766937,
      lng: 106.663168,
    ),
    RouteBus(
      id: 4,
      date: "2019-09-09",
      time: "04:00 pm",
      routeName: "Trường quốc tế việt úc",
      type: 1,
      status: false,
      lat: 10.766937,
      lng: 106.663168,
    ),
    RouteBus(
      id: 5,
      date: "2019-09-09",
      time: "04:30 pm",
      routeName: "285/94 cách mạng tháng 8, p12, q10",
      type: 1,
      status: false,
      lat: 10.776573,
      lng: 106.685157,
    ),
  ];

  static List<RouteBus> getListRouteBusByType(
      List<RouteBus> listRouteBus, int type) {
    return listRouteBus.where((item) => item.type == type).toList();
  }
}
