class Employee {
  int id;
  String name;
  String photo;
  String location = 'HCM, VN.';
  String gender;
  int age;

  Employee(this.id, this.name, this.photo, this.gender, this.age);
  // Names generated at http://random-name-generator.info/
  static final List<Employee> listEmployee = [
    Employee(
        1,
        'Ms Phương',
        "https://cdn.lolwot.com/wp-content/uploads/2016/02/20-of-the-most-unbelievably-stunning-women-1.jpg",
        'F',
        30),
    Employee(2, 'Ms Châu',
        "https://cdn.pornpics.com/pics/2011-07-02/17558_05big.jpg", 'F', 34),
    Employee(
        3, 'Mr Tho', "https://randomuser.me/api/portraits/men/81.jpg", 'M', 38),
    Employee(4, 'Mr Minh', "https://randomuser.me/api/portraits/men/83.jpg",
        'M', 35),
  ];

  static final List<String> userHobbies = [
    "Dancing",
    "Hiking",
    "Singing",
    "Reading",
    "Fishing"
  ];
}
