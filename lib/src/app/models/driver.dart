class Driver {
  int id;
  String name;
  String photo;
  String gender;
  String phone;

  Driver(this.id, this.name, this.photo, this.gender, this.phone);

  Driver.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    gender = json['gender'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["photo"] = this.photo;
    data["gender"] = this.gender;
    data["phone"] = this.phone;
    return data;
  }

  static final List<Driver> list = [
    Driver(
        1,
        'Driver 1',
        "https://shalimarbphotography.com/wp-content/uploads/2018/06/SBP-2539.jpg",
        'F',
        "0907488458"),
    Driver(
        2,
        'Driver 2',
        "https://shalimarbphotography.com/wp-content/uploads/2018/06/SBP-0800.jpg",
        'F',
        "0905123456"),
  ];
}
