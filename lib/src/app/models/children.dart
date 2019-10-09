class Children {
  int id;
  String name;
  String photo;
  String location = 'HCM, VN.';
  String gender;
  int age;
  bool primary;
  String schoolName;

  Children(
      {this.id,
      this.name,
      this.photo,
      this.gender,
      this.age,
      this.primary,
      this.schoolName});

  Children.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    location = json['location'];
    gender = json['gender'];
    age = json['age'];
    primary = json['primary'];
    schoolName = json['schoolName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["photo"] = this.photo;
    data["location"] = this.location;
    data["gender"] = this.gender;
    data["age"] = this.age;
    data["primary"] = this.primary;
    data["schoolName"] = this.schoolName;
    return data;
  }

  static List<Children> getChildrenByListID(
      List<Children> listChildren, List<int> listId) {
    List<Children> listResult = [];
    for (var id in listId) {
      var child = listChildren.singleWhere((child) => child.id == id);
      if (child != null) listResult.add(child);
    }
    return listResult;
  }

  static final List<Children> list = [
    Children(
        id: 1,
        name: 'Boy A',
        photo:
            "https://shalimarbphotography.com/wp-content/uploads/2018/06/SBP-2539.jpg",
        gender: 'F',
        age: 12,
        primary: true,
        schoolName: "VStar school"),
    Children(
        id: 2,
        name: 'Girl B',
        photo:
            "https://shalimarbphotography.com/wp-content/uploads/2018/06/SBP-0800.jpg",
        gender: 'F',
        age: 10,
        primary: false,
        schoolName: "VStar school"),
    Children(
        id: 3,
        name: 'Girl C',
        photo: "http://all4desktop.com/data_images/original/4240052-child.jpg",
        gender: 'F',
        age: 10,
        primary: false,
        schoolName: "VStar school"),
    Children(
        id: 4,
        name: 'Girl D',
        photo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlkl0i-KXPeU1RWvA1RZ8XzctHaKrFV_iiMlBCQIJieWhai02Q",
        gender: 'F',
        age: 10,
        primary: false,
        schoolName: "VStar school"),
  ];
}
