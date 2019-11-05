class ResPartnerTitle {
  dynamic sLastUpdate;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic displayName;
  dynamic id;
  dynamic name;
  dynamic shortcut;
  dynamic writeDate;
  List<dynamic> writeUid;

  ResPartnerTitle(
      {this.sLastUpdate,
      this.createDate,
      this.createUid,
      this.displayName,
      this.id,
      this.name,
      this.shortcut,
      this.writeDate,
      this.writeUid});

  ResPartnerTitle.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    createDate = json['create_date'];
    if (json["create_uid"] != null) {
      createUid = List<dynamic>.from(
          json["create_uid"] != null && (json["create_uid"] is bool) == false
              ? json["create_uid"]
              : []);
    }
    displayName = json['display_name'];
    id = json['id'];
    name = json['name'];
    shortcut = json['shortcut'];
    writeDate = json['write_date'];
    if (json["write_uid"] != null) {
      writeUid = List<dynamic>.from(
          json["write_uid"] != null && (json["write_uid"] is bool) == false
              ? json["write_uid"]
              : []);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__last_update'] = this.sLastUpdate;
    data['create_date'] = this.createDate;
    data['create_uid'] = this.createUid;
    data['display_name'] = this.displayName;
    data['id'] = this.id;
    data['name'] = this.name;
    data['shortcut'] = this.shortcut;
    data['write_date'] = this.writeDate;
    data['write_uid'] = this.writeUid;
    return data;
  }
}
