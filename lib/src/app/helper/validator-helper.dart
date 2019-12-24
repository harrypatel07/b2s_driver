import 'package:validators/validators.dart';

class Validator {
  static String validateEmail(String email) {
    if (email == null || email.trim() == "") return "Email required";
    var isValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (!isValid) return "Email is invalid";
    return null;
  }

  static String validatePassword(String pass) {
    if (pass == null || pass.trim() == "")
      return "Pass required";
    else if (pass.length < 6) return "Pass require min 6 characters";
    return null;
  }

  static String validateURL(String url) {
    if (url == null || url.trim() == "") return "Url required";
    var isValid = isURL(url, requireTld: false);
    if (!isValid) return "URL is invalid";
    return null;
  }

//  static String validatePhone(String phone) {
//    if (phone == null || phone.trim() == "") return "Phone required";
//    var isValid = RegExp(
//            r"^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$")
//        .hasMatch(phone);
//    if (!isValid) return "Phone is invalid";
//    return null;
//  }
  static String validatePhone(String phone) {
    if (phone == null || phone.trim() == "") return 'Phone required';
    else if(phone.length<1) return 'Phone required';
    return null;
  }
  static String validateName(String name) {
    if (name == null || name == "") return "Name required";
    else if(name.length<1) return "Name required";
    return null;
  }
  static String validateGender(String gender) {
    if (gender == null || gender == "") return "Gender required";
    else if(gender.length<1) return "Gender required";
    return null;
  }
  static String validateSchoolName(String schoolName) {
    if (schoolName == null || schoolName == "") return "School name required";
    else if(schoolName.length<1) return "School name required";
    return null;
  }
  static String validateAge(String age) {
    if (age == null || age.trim() == "") return "Age required";
    var isValid =
    RegExp(r"^[0-99]").hasMatch(age);
    if (!isValid) return "Age is invalid";
    return null;
  }
  static String validAddress(String address){
    if (address == null || address == '') return 'Address required';
    else if(address.length<1) return 'Address required';
    return null;
  }
}
