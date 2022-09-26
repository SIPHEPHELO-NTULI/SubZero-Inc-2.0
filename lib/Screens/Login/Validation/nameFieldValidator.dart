//validator for the name in the registration screen
// checks if the name is empty and if its in the correct format

class NameFieldValidator {
  static String? validate(String? value) {
    RegExp regex = RegExp(r'^.{3,}$');
    if (value!.isEmpty) {
      return ("Name Cannot be Empty");
    }
    if (!regex.hasMatch(value)) {
      return ("Please Enter Valid Name (3 Characters Min)");
    }
    return null;
  }
}
