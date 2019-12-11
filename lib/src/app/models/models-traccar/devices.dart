class Device {
  dynamic id;
  dynamic name;
  dynamic uniqueId;
  dynamic status;
  dynamic disabled;
  dynamic lastUpdate;
  dynamic positionId;
  dynamic groupId;
  dynamic phone;
  dynamic model;
  dynamic contact;
  dynamic category;
  List<dynamic> geofenceIds;
  dynamic attributes;

  Device(
      {this.id,
      this.name,
      this.uniqueId,
      this.status,
      this.disabled,
      this.lastUpdate,
      this.positionId,
      this.groupId,
      this.phone,
      this.model,
      this.contact,
      this.category,
      this.geofenceIds,
      this.attributes});

  Device.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    uniqueId = json['uniqueId'];
    status = json['status'];
    disabled = json['disabled'];
    lastUpdate = json['lastUpdate'];
    positionId = json['positionId'];
    groupId = json['groupId'];
    phone = json['phone'];
    model = json['model'];
    contact = json['contact'];
    category = json['category'];
    geofenceIds = json['geofenceIds'];
    attributes = json['attributes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) data['id'] = this.id;
    if (this.name != null) data['name'] = this.name;
    if (this.uniqueId != null) data['uniqueId'] = this.uniqueId;
    if (this.status != null) data['status'] = this.status;
    if (this.disabled != null) data['disabled'] = this.disabled;
    if (this.lastUpdate != null) data['lastUpdate'] = this.lastUpdate;
    if (this.positionId != null) data['positionId'] = this.positionId;
    if (this.groupId != null) data['groupId'] = this.groupId;
    if (this.phone != null) data['phone'] = this.phone;
    if (this.model != null) data['model'] = this.model;
    if (this.contact != null) data['contact'] = this.contact;
    if (this.category != null) data['category'] = this.category;
    if (this.geofenceIds != null) data['geofenceIds'] = this.geofenceIds;
    if (this.attributes != null) data['attributes'] = this.attributes;
    return data;
  }
}
