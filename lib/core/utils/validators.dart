import 'constants.dart';

class Validators {
  static bool isValidEmail(String email) {
    return emailRegExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return passwordRegExp.hasMatch(password);
  }
}
