class PickingRoute {
  dynamic sLastUpdate;
  dynamic createDate;
  dynamic createUid;
  dynamic deliveryId;
  dynamic deliveryRouteId;
  dynamic destinationLocation;
  dynamic displayName;
  dynamic distance;
  dynamic endTime;
  dynamic gpsTracking;
  dynamic hour;
  dynamic id;
  dynamic note;
  dynamic sourceLocation;
  dynamic startTime;
  dynamic status;
  dynamic writeDate;
  dynamic writeUid;

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
      this.writeUid});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__last_update'] = this.sLastUpdate;
    data['create_date'] = this.createDate;
    data['create_uid'] = this.createUid;
    data['delivery_id'] = this.deliveryId;
    data['delivery_route_id'] = this.deliveryRouteId;
    data['destination_location'] = this.destinationLocation;
    data['display_name'] = this.displayName;
    data['distance'] = this.distance;
    data['end_time'] = this.endTime;
    data['gps_tracking'] = this.gpsTracking;
    data['hour'] = this.hour;
    data['id'] = this.id;
    data['note'] = this.note;
    data['source_location'] = this.sourceLocation;
    data['start_time'] = this.startTime;
    data['status'] = this.status;
    data['write_date'] = this.writeDate;
    data['write_uid'] = this.writeUid;
    return data;
  }
}
