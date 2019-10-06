class Children {
  int id;
  String name;
  String photo;
  String location = 'HCM, VN.';
  String gender;
  int age;
  Children(this.id, this.name, this.photo, this.gender, this.age);

  static List<Children> getChildrenByListID( List<Children> listChildren, List<int> listId) {
     List<Children> listResult = [];
    for (var id in listId) {
      var child = listChildren.singleWhere((child) => child.id == id); 
      if(child != null) listResult.add(child);
    }
  return listResult;
  }

  static final List<Children> list = [
    Children(
        1,
        'Boy A',
        "https://shalimarbphotography.com/wp-content/uploads/2018/06/SBP-2539.jpg",
        'F',
        12),
    Children(
        2,
        'Girl B',
        "https://shalimarbphotography.com/wp-content/uploads/2018/06/SBP-0800.jpg",
        'F',
        10),
    Children(
        3,
        'Girl C',
        "https://shalimarbphotography.com/wp-content/uploads/2018/06/SBP-0800.jpg",
        'F',
        10),
    Children(
        4,
        'Girl D',
        "https://shalimarbphotography.com/wp-content/uploads/2018/06/SBP-0800.jpg",
        'F',
        10),
  ];
}
