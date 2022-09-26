//validator for the username in the registration screen
// checks if the username is empty and if its in the correct format

class UserNameFieldValidator {
  static String? validate(String? value) {
    RegExp regex = new RegExp(r'^.{3,}$');
    if (value!.isEmpty) {
      return ("Username Cannot be Empty");
    }
    if (!regex.hasMatch(value)) {
      return ("Please Enter Valid Username (3 Characters Min)");
    }
  }
}
