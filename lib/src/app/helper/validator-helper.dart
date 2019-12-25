import 'package:validators/validators.dart';

class Validator {
  static String validateEmail(String email) {
    if (email == null || email.trim() == "") return "Không được để trống email";
    var isValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (!isValid) return "Email không đúng";
    return null;
  }

  static String validatePassword(String pass) {
    if (pass == null || pass.trim() == "")
      return "Không được để trống mật khẩu";
    else if (pass.length < 6) return "Mật khẩu ít nhất phải 6 ký tự";
    return null;
  }

  static String validateURL(String url) {
    if (url == null || url.trim() == "") return "Không được để trống đường dẫn";
    var isValid = isURL(url, requireTld: false);
    if (!isValid) return "URL không đúng";
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
    if (phone == null || phone.trim() == "") return 'Không được để trống số điện thoại';
    else if(phone.length<1) return 'Không được để trống số điện thoại';
    return null;
  }
  static String validateName(String name) {
    if (name == null || name == "") return "Không được để trống tên";
    else if(name.length<1) return "Không được để trống tên";
    return null;
  }
  static String validateGender(String gender) {
    if (gender == null || gender == "") return "Không được để trống giới tính";
    else if(gender.length<1) return "Không được để trống giới tính";
    return null;
  }
  static String validateSchoolName(String schoolName) {
    if (schoolName == null || schoolName == "") return "Không được để trống tên trường học";
    else if(schoolName.length<1) return "Không được để trống tên trường học";
    return null;
  }
  static String validateAge(String age) {
    if (age == null || age.trim() == "") return "Không được để trống tuổi";
    var isValid =
    RegExp(r"^[0-99]").hasMatch(age);
    if (!isValid) return "Tuổi không đúng";
    return null;
  }
  static String validAddress(String address){
    if (address == null || address == '') return 'Không được để trống địa chỉ';
    else if(address.length<1) return 'Không được để trống địa chỉ';
    return null;
  }
}
