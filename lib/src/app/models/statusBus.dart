class StatusBus {
  int statusID;
  String statusName;
  int statusColor;

  StatusBus(this.statusID, this.statusName, this.statusColor);

  StatusBus.fromJson(Map<dynamic, dynamic> json) {
    statusID = json['statusID'];
    statusName = json['statusName'];
    statusColor = json['statusColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["statusID"] = this.statusID;
    data["statusName"] = this.statusName;
    data["statusColor"] = this.statusColor;
    return data;
  }

  static StatusBus getStatusByID(List<StatusBus> list, id) {
    return list.singleWhere((item) => item.statusID == id);
  }

  static List<StatusBus> list = [
    StatusBus(0, "Đang chờ", 0xFFFFD752),
    StatusBus(1, "Đang trong chuyến", 0xFF8FD838),
    StatusBus(2, "Đã tới trường", 0xFF3DABEC),
    StatusBus(3, "Nghỉ học", 0xFFE80F0F),
    StatusBus(4, "Đã về nhà", 0xFF6F32A0),
  ];
}
