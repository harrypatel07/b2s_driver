class PickingRoute {
  dynamic sLastUpdate;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic deliveryId;
  List<dynamic> deliveryRouteId;
  List<dynamic> destinationLocation;
  dynamic displayName;
  dynamic distance;
  dynamic endTime;
  dynamic gpsTracking;
  dynamic hour;
  dynamic id;
  dynamic note;
  List<dynamic> sourceLocation;
  dynamic startTime;
  dynamic status;
  dynamic writeDate;
  List<dynamic> writeUid;
  dynamic xGpsTrackingDes;
  dynamic xRealEndTime;
  dynamic xRealStartTime;

  PickingRoute(
      {this.sLastUpdate,
      this.createDate,
      this.createUid,
      this.deliveryId,
      this.deliveryRouteId,
      this.destinationLocation,
      this.displayName,
      this.distance,
      this.endTime,
      this.gpsTracking,
      this.hour,
      this.id,
      this.note,
      this.sourceLocation,
      this.startTime,
      this.status,
      this.writeDate,
      this.writeUid,
      this.xGpsTrackingDes,
      this.xRealEndTime,
      this.xRealStartTime});

  PickingRoute.fromJsonController(Map<String, dynamic> json) {
    xRealEndTime = json["real_end_time"];
    xRealStartTime = json["real_start_time"];
    startTime = json["start_time"];
    endTime = json["end_time"];
    status = json["status"];
    id = json["id"];
    gpsTracking = json["gps_tracking"] is bool ? 0 : json["gps_tracking"];
    xGpsTrackingDes =
        json["gps_tracking_des"] is bool ? 0 : json["gps_tracking_des"];
  }
  PickingRoute.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    createDate = json['create_date'];
    createUid = json['create_uid'];
    deliveryId = json['delivery_id'];
    deliveryRouteId = json['delivery_route_id'];
    destinationLocation = json['destination_location'];
    displayName = json['display_name'];
    distance = json['distance'];
    endTime = json['end_time'];
    gpsTracking = json['gps_tracking'];
    hour = json['hour'];
    id = json['id'];
    note = json['note'];
    sourceLocation = json['source_location'];
    startTime = json['start_time'];
    status = json['status'];
    writeDate = json['write_date'];
    writeUid = json['write_uid'];
    xGpsTrackingDes = json['x_gps_tracking_des'];
    xRealEndTime = json['x_real_end_time'];
    xRealStartTime = json['x_real_start_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sLastUpdate != null) data['__last_update'] = this.sLastUpdate;
    if (this.createDate != null) data['create_date'] = this.createDate;
    if (this.createUid != null) data['create_uid'] = this.createUid;
    if (this.deliveryId != null) data['delivery_id'] = this.deliveryId;
    if (this.deliveryRouteId != null)
      data['delivery_route_id'] = this.deliveryRouteId;
    if (this.destinationLocation != null)
      data['destination_location'] = this.destinationLocation;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.distance != null) data['distance'] = this.distance;
    if (this.endTime != null) data['end_time'] = this.endTime;
    if (this.gpsTracking != null) data['gps_tracking'] = this.gpsTracking;
    if (this.hour != null) data['hour'] = this.hour;
    if (this.id != null) data['id'] = this.id;
    if (this.note != null) data['note'] = this.note;
    if (this.sourceLocation != null)
      data['source_location'] = this.sourceLocation;
    if (this.startTime != null) data['start_time'] = this.startTime;
    if (this.status != null) data['status'] = this.status;
    if (this.writeDate != null) data['write_date'] = this.writeDate;
    if (this.writeUid != null) data['write_uid'] = this.writeUid;
    if (this.xGpsTrackingDes != null)
      data['x_gps_tracking_des'] = this.xGpsTrackingDes;
    if (this.xRealEndTime != null) data['x_real_end_time'] = this.xRealEndTime;
    if (this.xRealStartTime != null)
      data['x_real_start_time'] = this.xRealStartTime;
    return data;
  }
}
