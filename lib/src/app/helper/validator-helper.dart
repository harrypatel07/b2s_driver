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

  static String validatePhone(String phone) {
    if (phone == null || phone.trim() == "") return "Phone required";
    var isValid = RegExp(
            r"^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$")
        .hasMatch(phone);
    if (!isValid) return "Phone is invalid";
    return null;
  }
}
