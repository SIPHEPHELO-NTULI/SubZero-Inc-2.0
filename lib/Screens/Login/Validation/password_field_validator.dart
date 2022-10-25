//validator for the password in the registration screen and login page
// checks if the category is empty and if its in the correct format

class PasswordFieldValidator {
  static String? validate(String? value) {
    RegExp regex = RegExp(r'^.{6,}$');
    if (value!.isEmpty) {
      return "Password Required";
    }

    if (!regex.hasMatch(value)) {
      return "Please Enter Valid Password (6 Characters Min)";
    }
    return null;
  }
}
