class DeviceAccumulators {
  dynamic deviceId;
  dynamic totalDistance;
  dynamic hours;

  DeviceAccumulators({this.deviceId, this.totalDistance, this.hours});

  DeviceAccumulators.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    totalDistance = json['totalDistance'];
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deviceId != null) data['deviceId'] = this.deviceId;
    if (this.totalDistance != null) data['totalDistance'] = this.totalDistance;
    if (this.hours != null) data['hours'] = this.hours;
    return data;
  }
}
