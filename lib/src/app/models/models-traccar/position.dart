class Positions {
  dynamic id;
  dynamic deviceId;
  dynamic protocol;
  dynamic deviceTime;
  dynamic fixTime;
  dynamic serverTime;
  dynamic outdated;
  dynamic valid;
  dynamic latitude;
  dynamic longitude;
  dynamic altitude;
  dynamic speed;
  dynamic course;
  dynamic address;
  dynamic accuracy;
  dynamic network;
  dynamic attributes;
  dynamic battery;

  Positions(
      {this.id,
      this.deviceId,
      this.protocol,
      this.deviceTime,
      this.fixTime,
      this.serverTime,
      this.outdated,
      this.valid,
      this.latitude,
      this.longitude,
      this.altitude,
      this.speed,
      this.course,
      this.address,
      this.accuracy,
      this.network,
      this.attributes,
      this.battery});

  Positions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['deviceId'];
    protocol = json['protocol'];
    deviceTime = json['deviceTime'];
    fixTime = json['fixTime'];
    serverTime = json['serverTime'];
    outdated = json['outdated'];
    valid = json['valid'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    altitude = json['altitude'];
    speed = json['speed'];
    course = json['course'];
    address = json['address'];
    accuracy = json['accuracy'];
    network = json['network'];
    attributes = json['attributes'];
    battery = json['battery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) data['id'] = this.id;
    if (this.deviceId != null) data['deviceId'] = this.deviceId;
    if (this.protocol != null) data['protocol'] = this.protocol;
    if (this.deviceTime != null) data['deviceTime'] = this.deviceTime;
    if (this.fixTime != null) data['fixTime'] = this.fixTime;
    if (this.serverTime != null) data['serverTime'] = this.serverTime;
    if (this.outdated != null) data['outdated'] = this.outdated;
    if (this.valid != null) data['valid'] = this.valid;
    if (this.latitude != null) data['latitude'] = this.latitude;
    if (this.longitude != null) data['longitude'] = this.longitude;
    if (this.altitude != null) data['altitude'] = this.altitude;
    if (this.speed != null) data['speed'] = this.speed;
    if (this.course != null) data['course'] = this.course;
    if (this.address != null) data['address'] = this.address;
    if (this.accuracy != null) data['accuracy'] = this.accuracy;
    if (this.network != null) data['network'] = this.network;
    if (this.attributes != null) data['attributes'] = this.attributes;
    if (this.battery != null) data['battery'] = this.battery;
    return data;
  }

  ///Convert ra OpenStreetMap Automated Navigation Directions
  Map<String, String> toJsonOsmAnd() {
    final Map<String, String> data = new Map<String, String>();
    if (this.deviceId != null) data['id'] = this.deviceId.toString();
    data['timestamp'] = DateTime.now().millisecondsSinceEpoch.toString();
    if (this.latitude != null) data['lat'] = this.latitude.toString();
    if (this.longitude != null) data['lon'] = this.longitude.toString();
    if (this.speed != null) data['speed'] = this.speed.toString();
    if (this.course != null) data['bearing'] = this.course.toString();
    if (this.altitude != null) data['altitude'] = this.altitude.toString();
    if (this.accuracy != null) data['accuracy'] = this.accuracy.toString();
    if (this.battery != null) data['batt'] = this.battery.toString();
    return data;
  }
}
