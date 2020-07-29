

import 'package:flutter/cupertino.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:regexed_validator/regexed_validator.dart';

class InputFieldValidator{

  //Required validators, field must have.
  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(6, errorText: 'Password must be at least 6 digits long'),
    PatternValidator(r'(?=.*[a-z])',errorText: "passwords must have at least one lower case character"),
    PatternValidator(r'(?=.*[A-Z])',errorText: "passwords must have at least one upper case character"),
    PatternValidator(r'(?=.*\d)',errorText: "passwords must have at least one number"),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character'),
  ]);

  static final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    RealEmailValidator(errorText: 'Enter valid Email'),
  ]);


  //Below validators do not include checking field is empty

  static final phoneValidator = PhoneValidator(errorText: 'Enter valid phone number');

  static final priceValidator = MultiValidator([
    NumberValidator(max: null,min: null,errorText: 'Enter a number'),
    NumberValidator(min: 0, errorText: 'Price must be non-negative'),
  ]);

  static final percentageValidator = MultiValidator([
    NumberValidator(max: null,min: null,errorText: 'Enter a number'),
    NumberValidator(min: 0, max: 100, errorText: 'Invalid discount rate')
  ]);
}

class PhoneValidator extends TextFieldValidator{
  PhoneValidator({@required String errorText}) : super(errorText);
  @override
  bool isValid(String value) {
    if(value==null || value == "") return true;
    return validator.phone(value);
  }
}

class NumberValidator extends TextFieldValidator {
  final double min;
  final double max;
  NumberValidator({ this.min,  this.max, @required String errorText})
      : super(errorText);
  @override
  bool get ignoreEmptyValues => true;

  @override
  bool isValid(String value) {
    if(value==null || value == "") return true;
    try {
      if(min == null && max == null) return num.parse(value)!=null; // is number validator

      final numericValue = num.parse(value);

      if(max==null) return numericValue >= min; //min value validator

      if(min==null) return numericValue <= max; // max value validator

      return (numericValue >= min && numericValue <= max); // range validator

    } catch (_) {
      return false;
    }
  }
}

class RealEmailValidator extends EmailValidator{
  String errorText = "Wrong email format!";
  RealEmailValidator({ @required String errorText}) : super(errorText: errorText);
  RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  @override
  bool isValid(String value) {
    return emailValid.hasMatch(value);
  }
}