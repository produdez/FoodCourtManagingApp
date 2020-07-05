

import 'package:regexed_validator/regexed_validator.dart';

class StringValidator {
  static bool isValidEmail(String email){
    return validator.email(email);
  }
  static bool isValidPassword(String password){
    return validator.password(password);
  }
  static bool isValidName(String name){
    return validator.name(name);
  }
  static bool isValidPhone(String phone){
    return validator.name(phone);
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s) != null;
  }
}
